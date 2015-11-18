class API::JobPostingsController < ApplicationController

  # get all the job postings
  def index
    qs = job_posting_params[:q].nil? ? {} : { _all: job_posting_params[:q] }
    response = JobPosting.search(qs)
    @job_postings = response.page(job_posting_params[:page]).as_json
    postings_total = response.response.hits.total
    max_postings_shown = JobPosting.per_page * job_posting_params[:page].to_i
    postings_shown = max_postings_shown > postings_total ? postings_total : max_postings_shown

    render json: @job_postings,
           each_serializer: JobPostingsSerializer,
           meta: { postings_total: postings_total,
                   postings_shown: postings_shown,
                   page: job_posting_params[:page] }
  end

  def show
    @job_posting = JobPosting.find(params[:id])
    render json: @job_posting, serializer: JobPostingSerializer, root: false
  end

  private
  def job_posting_params
    params.require(:search).permit(:page, :title, :company, :source, :location, :date_posted, :anything, :q)
  end
end
