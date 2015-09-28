module MailingListsHelper
  def bounce_options
    [['Yes', 1], ['No', 0]]
  end

  def unsubscribe_options
    [['Yes', 1], ['No', 0]]
  end
end
