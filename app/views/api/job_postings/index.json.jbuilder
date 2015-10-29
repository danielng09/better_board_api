json.array! @job_postings do |job_posting|
  json.extract! job_posting, :id, :title, :company, :date_posted
end
