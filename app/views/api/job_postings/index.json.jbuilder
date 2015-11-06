json.array! @job_postings do |job_posting|
  json.title job_posting.title
  json.company job_posting.company
  json.source job_posting.source
  json.location job_posting.location
  json.date_posted job_posting.date_posted.strftime("%m/%d/%Y")
end
