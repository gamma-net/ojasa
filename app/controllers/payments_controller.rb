class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:receive_webhook]

  before_filter :validate_login
  before_filter :validate_order_id, only: [:index, :process_payment]
  
  def index
    @payment = make_payment
    redirect_to receipt_order_services_url(order_id: @order.id) and return unless @order.pending_payment?
  end
  
  def process_payment
    @payment = make_payment

    @result = Veritrans.charge(
      payment_type: "credit_card",
      credit_card: { token_id: params[:payment][:token_id] },
      transaction_details: {
        order_id: @payment.order_id,
        gross_amount: params[:payment][:amount].presence || @payment.amount
      }
    )

=begin
4811111111111114
{"status_code":"200","status_message":"Success, Credit Card transaction is successful","transaction_id":"656be6f2-9bc7-408a-a29b-3e856f0da5e6","masked_card":"481111-1114","order_id":"ojasa-38-1446352467","gross_amount":"125000.00","payment_type":"credit_card","transaction_time":"2015-11-01 11:34:27","transaction_status":"capture","fraud_status":"accept","approval_code":"1446352470612","bank":"mandiri"}
=end

    @order.status_code = @result.status_code
    @order.status_message = @result.status_message
    case @order.status_code
    when '200'
      @order.payment_type = @result.payment_type
      @order.transaction_id = @result.transaction_id
      @order.transaction_time = @result.transaction_time
      @order.transaction_status = @result.transaction_status
      @order.fraud_status = @result.fraud_status
      @order.approval_code = @result.approval_code
      @order.masked_card = @result.masked_card
      @order.veritrans_order_id = @result.order_id
      @order.bank = @result.bank
      @order.status_id = Order.pending_work   # @order.pay!
      @order.save
      CustomerMailer.payment_received(@order).deliver_now
      AdminMailer.notify_support(@order, "Paid order waiting for work").deliver_now
      redirect_to thanks_payments_url and return
    end
    @order.save
    flash[:error] = 'We are sorry, we cannot charge your credit card at the moment. Please try again shortly.'
    redirect_to payments_url(order_id: @order.id)
  end
  
  # def vtweb
  #   @payment = make_payment
  #   if params[:type] == "vtweb"
  #     @result = Veritrans.charge(
  #       payment_type: "VTWEB",
  #       transaction_details: {
  #         order_id: @payment.order_id,
  #         gross_amount: @payment.amount
  #       }
  #     )
  #     redirect_to @result.redirect_url
  #     return
  #   end
  # end

  def receive_webhook
    post_body = request.body.read

    Veritrans.file_logger.info("Callback for order: " +
      "#{params[:order_id]} #{params[:transaction_status]}\n" +
      post_body + "\n"
    )

    verified_data = Veritrans.status(params["transaction_id"])

    if verified_data.status_code != 404
      puts "--- Transaction callback ---"
      puts "Payment:        #{verified_data.data[:order_id]}"
      puts "Payment type:   #{verified_data.data[:payment_type]}"
      puts "Payment status: #{verified_data.data[:transaction_status]}"
      puts "Fraud status:   #{verified_data.data[:fraud_status]}" if verified_data.data[:fraud_status]
      puts "Payment amount: #{verified_data.data[:gross_amount]}"
      puts "--- Transaction callback ---"

      render text: "ok"
    else
      Veritrans.file_logger.info("Callback verification failed for order: " +
        "#{params[:order_id]} #{params[:transaction_status]}}\n" +
        verified_data.body + "\n"
      )

      render text: "ok", :status => :not_found
    end

  end

  private
  
    def make_payment
      @paymentKlass = Struct.new("Payment", :amount, :token_id, :order_id, :credit_card_secure) do
        extend ActiveModel::Naming
        include ActiveModel::Conversion

        def persisted?; false; end

        def self.name
          "Payment"
        end
      end

      @paymentKlass.new(@order.subtotal, '', "ojasa-#{@order.id}-#{Time.now.to_i}", false)
    end
    
    def validate_order_id
      @order = Order.where(id: params[:order_id], customer_id: session[:customer]['id']).first
      unless @order
        flash[:error] = 'We are sorry, we cannot find your order at the moment'
        redirect_to order_services_url and return
      end
    end

end