module FeedbackHelper
  def feedback_options
    options = [['Not Rated Yet', nil]]
    5.downto(1) do |i|
      options << [pluralize(i, 'Star'), i]
    end
    options
  end
end
