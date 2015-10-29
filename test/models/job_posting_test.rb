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
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class JobPostingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
