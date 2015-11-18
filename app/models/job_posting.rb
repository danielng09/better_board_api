# == Schema Information
#
# Table name: job_postings
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  company     :string
#  location    :string           not null
#  description :text             not null
#  url         :string           not null
#  date_posted :datetime         not null
#  source      :string           not null
#  source_id   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null

class JobPosting < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :date_posted, type: 'float'
    end
  end

  def self.search(query)
    match_key = query.empty? ? :match_all : :match
    __elasticsearch__.search({
      query: {
        "#{match_key}": query
      },
      sort: {
        date_posted: { order: :desc }
      },
      size: self.per_page
    })
  end

  self.per_page = 20

  def self.total_pages
    self.count / self.per_page
  end
end
