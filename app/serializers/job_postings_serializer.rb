class JobPostingsSerializer < ActiveModel::Serializer
  attributes :title, :company, :source, :location, :date_posted

  def date_posted
    object.date_posted.strftime("%m/%d/%Y")
  end
end
