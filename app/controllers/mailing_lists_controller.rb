class MailingListsController < ApplicationController
  layout 'admin'
  
  def index
    @mailing_lists = MailingList.all
  end

  def new
    @mailing_list = MailingList.new
  end
  
  def create
    @mailing_list = MailingList.new(mailing_list_params)
    if @mailing_list.save
      flash[:success] = 'Mailing List Create success!'
      redirect_to edit_admin_mailings_list_url(id: @mailing_list.id) and return
    end
    @errors = @mailing_list.errors
    flash[:error] = "We're sorry, we cannot create the mailing list at the moment"
    render template: 'mailing_lists/new'
  end

  def edit
    @mailing_list = MailingList.find(params[:id])
  end
  
  def update
    @mailing_list = MailingList.find(params[:id])
    if @mailing_list.update_attributes(mailing_list_params)
      flash[:success] = 'Mailing List Update success!'
      redirect_to edit_admin_mailings_list_url and return
    end
    @errors = @mailing_list.errors
    flash[:error] = "We're sorry, we cannot update the mailing list at the moment"
    render template: 'mailing_lists/edit'
  end
  
  def destroy
    MailingList.find(params[:id]).destroy
    redirect_to admin_mailings_lists_url
  end
  
  def signup
    # (recaptcha_valid? ? "RECAPTCHA VALID" : "RECAPTCHA INVALID!")

    url = "https://www.google.com/recaptcha/api/siteverify"
    secret_param = "secret=#{ENV['RECAPTCHA_PRIVATE_KEY']}"
    response_param = "response=#{params['g-recaptcha-response']}"
    
    response = %x{curl -X POST -d #{secret_param} -d #{response_param} #{url}}
    # p response

    if JSON.parse(response)["success"]
      mailing = MailingList.new(mailing_list_params)
      if mailing.save
        flash[:success] = "You have successfully added your information to our mailing list"
      else
        flash[:errors] = mailing.errors
        flash[:error] = "We are sorry we cannot add you to the mailing list for now"
      end
    else
      flash[:error] = "We are sorry we cannot verify whether you are a person"
    end
    redirect_to :back
  end

  protected
  
    def mailing_list_params
      params.require(:mailing_list).permit!
    end
end
