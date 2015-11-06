class JobPostingSerializer < ActiveModel::Serializer
  attributes :title, :company, :source, :location, :date_posted, :description, :url

  def date_posted
    object.date_posted.strftime("%m/%d/%Y")
  end
end
