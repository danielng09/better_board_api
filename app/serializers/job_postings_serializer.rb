include ActionView::Helpers::DateHelper

class JobPostingsSerializer < ActiveModel::Serializer
  attributes :id, :title, :company, :source, :location, :date_posted, :time_ago

  def date_posted
    object.date_posted.strftime("%m/%d/%Y")
  end

  def time_ago
    time_ago_in_words(object.date_posted)
  end
end
