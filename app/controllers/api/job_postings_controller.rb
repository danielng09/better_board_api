class API::JobPostingsController < ApplicationController

  # get all the job postings
  def index
    @job_postings = JobPosting.all
    render json: @job_postings, each_serializer: JobPostingsSerializer, root: false
  end

  def show
    @job_posting = JobPosting.find(params[:id])
    render json: @job_posting, serializer: JobPostingSerializer, root: false
  end
end
