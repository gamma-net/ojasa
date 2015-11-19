class Order < ActiveRecord::Base
  has_many :order_items
  has_many :feedbacks
  alias :items :order_items

  belongs_to :customer
  belongs_to :category
  belongs_to :service
  # belongs_to :shipping_address, class_name: 'Address'
  # belongs_to :billing_address, class_name: 'Address'
  
  STATUSES = {1 => 'Open',
              2 => 'Pending Payment',
              3 => 'Pending Work',
              4 => 'Processing',
              5 => 'Processed',
              0 => 'Cancelled'}.freeze

  delegate :email, :full_name, :phone, :full_address, :customer_address, :addressdetail, to: :customer
  
  attr_accessor :freeze_discount
  
  def status; STATUSES[status_id];  end
  
  def open!;    update_attribute(:status_id, Order.open);             end
  def order!;   update_attribute(:status_id, Order.pending_payment);  end
  def pay!;     update_attribute(:status_id, Order.pending_work);     end
  def work!;    update_attribute(:status_id, Order.processing);       end
  def done!;    update_attribute(:status_id, Order.processed);        end
  def cancel!;  update_attribute(:status_id, Order.cancelled);        end
  
  def open?;              status_id == Order.open;      end
  def cancelled?;         status_id == Order.cancelled; end
  def processed?;         status_id == Order.processed; end
  def pending_payment?;   status_id == Order.pending_payment; end
  def pending_work?;      status_id == Order.pending_work; end
  def processed?;         status_id == Order.processed; end
  
  def send_email?;            send_payment_request? || send_warrior_info? || send_feedback_request?; end
  def send_payment_request?;  pending_payment?;           end
  def send_warrior_info?;     pending_work? && service;   end
  def send_feedback_request?; processed?;                 end 
  
  class << self
    def open!(order_id);      Order.find(order_id).open!;     end
    def order!(order_id);     Order.find(order_id).order!;  end
    def pay!(order_id);       Order.find(order_id).pay!;     end
    def work!(order_id);      Order.find(order_id).work!;   end
    def done!(order_id);      Order.find(order_id).done!;  end
    def cancel!(order_id);    Order.find(order_id).cancel!;   end

    def status_id?(status_name)
      STATUSES.detect {|k,v| v == status_name}.first || 1
    end
    
    def open;             Order.status_id?('Open');             end
    def pending_payment;  Order.status_id?('Pending Payment');  end
    def pending_work;     Order.status_id?('Pending Work');     end
    def processing;       Order.status_id?('Processing');       end
    def processed;        Order.status_id?('Processed');        end
    def cancelled;        Order.status_id?('Cancelled');        end
    
    def all_statuses
      [open, pending_payment, pending_work, processing, processed, cancelled]
    end
  end
  
  def validate?
    !requested_date.nil? && !requested_time.blank? && !past_date? && !category_id.to_i.zero? && !address.blank? && !detail.blank? && !subtotal.to_i.zero?
  end
  
  def past_date?
     !requested_date.nil? && ((requested_date < Date.today) || ((requested_date == Date.today) && past_time?))
  end
  
  def past_time?
    return false if requested_time.nil? 
    time_now = Time.now
    time = requested_time.split('.')
    hour = time.first.to_i
    minute = time.last.to_i
    
    if (hour < (time_now.hour + time_interval)); return true 
    elsif (hour == (time_now.hour + time_interval)) && (minute < Time.now.min); return true
    else; return false
    end
  end
  
  def update_items(order_items)
    self.order_items = []
    order_items.each do |k, v|
      order_item = OrderItem.find(k)
      order_item.update_attributes(v)
      self.order_items << order_item
    end
    save
  end
  
  def calculate_total
    subtotal.to_f - discount.to_f + tax.to_f + shipping.to_f
  end
  
  def calculate!
    # calculate_subtotal!
    calculate_discount! unless freeze_discount
    self.total = calculate_total
    save!
  end

  def calculate_subtotal!
    self.subtotal = items.inject(0) {|subtotal, i| subtotal += (i.original_price * i.quantity)}
  end
  
  def calculate_discount!
    self.discount = items.inject(0) {|discount, i| discount += (i.discount * i.quantity)}
  end
  
  def category_name;  category ? category.name : '';  end
  def service_name;  service ? service.name : '';  end
  
  def pricing_desc
    category.pricing_desc(subtotal.round)
  end
  
  def category_service_name
    str = category_name
    str << " (#{service.name})" if service_id
    str
  end
  
  def feedback!(feedback_params={})
    Feedback.create(feedback_params)
  end
  
  protected
  
    def time_interval
      cat_time_interval = category.time_interval
      cat_time_interval - ((ENV['RAILS_ENV'] == 'production') ? 1 : 0) # Singapore Time
    end
end
