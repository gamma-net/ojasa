class MailingCampaignsController < ApplicationController
  layout 'admin'
  
  def index
    @mailings = Mailing.all
  end

  def new
    @mailing = Mailing.new
  end
  
  def create
    @mailing = Mailing.new(mailing_params)
    if @mailing.save
      flash[:success] = 'Mailing List Create success!'
      redirect_to edit_admin_mailings_campaign_url(id: @mailing.id) and return
    end
    @errors = @mailing.errors
    flash[:error] = "We're sorry, we cannot create the mailing list at the moment"
    render template: 'mailing_campaigns/new'
  end

  def edit
    @mailing = Mailing.find(params[:id])
  end
  
  def update
    @mailing = Mailing.find(params[:id])
    if @mailing.update_attributes(mailing_params)
      flash[:success] = 'Mailing List Update success!'
      redirect_to edit_admin_mailings_campaign_url and return
    end
    @errors = @mailing.errors
    flash[:error] = "We're sorry, we cannot update the mailing list at the moment"
    render template: 'mailing_campaigns/edit'
  end
  
  def destroy
    Mailing.find(params[:id]).destroy
    redirect_to admin_mailings_campaigns_url
  end
  
  protected
  
    def mailing_params
      params.require(:mailing).permit!
    end
end
