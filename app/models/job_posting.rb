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
#

class JobPosting < ActiveRecord::Base
  self.per_page = 5
end
