class JobPostingSerializer < ActiveModel::Serializer
  attributes :title, :company, :source, :location, :date_posted, :description
end
