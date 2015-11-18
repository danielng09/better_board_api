include ActionView::Helpers::DateHelper

class JobPostingsSerializer < ActiveModel::Serializer
  attributes :id, :title, :company, :source, :location, :date_posted, :time_ago, :score

  def id
    object['_source']['id']
  end

  def title
    object['_source']['title']
  end

  def company
    object['_source']['company']
  end

  def source
    object['_source']['source']
  end

  def location
    object['_source']['location']
  end

  def score
    object['_score']
  end

  def date_posted
    object['_source']['date_posted'].in_time_zone("Pacific Time (US & Canada)")
                                    .strftime("%m/%d/%Y")
  end

  def time_ago
    time_ago_in_words(object['_source']['date_posted'])
  end

end
