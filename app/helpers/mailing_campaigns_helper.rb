module MailingCampaignsHelper
  def draft_options
    [['Yes', 1], ['No', 0]]
  end
  
  def mailing_type_options
    Mailing::TYPES.collect {|k,v| [v, k]}
  end
end
