# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  provider         :string
#  uid              :string
#  name             :string
#  email            :string
#  oauth_token      :string
#  oauth_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ActiveRecord::Base
  GOOGLE_ENDPOINT = "https://www.googleapis.com/oauth2/v3/tokeninfo"

  def self.validate_id_token(id_token)
    output = JSON.parse(RestClient.get(GOOGLE_ENDPOINT, {params: {id_token: id_token}}))
    if output['error_description']
      nil
    else
      { pid: output['sub'],
        name: output['name'],
        imageUrl: output['picture'],
        email: output['email'] }
    end
  end

  def self.find_or_create(user_info)
    where(user_info).first_or_initialize.tap do |user|
      user.pid = user_info[:pid]
      user.name = user_info[:name]
      user.imageUrl = user_info[:imageUrl]
      user.email = user_info[:email]
      user.last_login = Time.now()
      user.save!
    end
  end
end
