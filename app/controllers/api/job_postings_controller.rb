class API::JobPostingsController < ApplicationController

  # get all the job postings
  def index
    qs = job_posting_params[:q].empty? ? {} : { _all: job_posting_params[:q] }
    response = JobPosting.search(qs)
    @job_postings = response.page(job_posting_params[:page]).as_json

    #move page info logic into model layer
    postings_total = response.response.hits.total
    max_postings_shown = JobPosting.per_page * job_posting_params[:page].to_i
    div, mod = postings_total.divmod(JobPosting.per_page)
    total_pages = mod == 0 ? div : div + 1
    postings_shown = max_postings_shown > postings_total ? postings_total : max_postings_shown

    render json: @job_postings,
           each_serializer: JobPostingsSerializer,
           meta: { postings_total: postings_total,
                   postings_shown: postings_shown,
                   page: job_posting_params[:page],
                   total_pages: total_pages}
  end

  def show
    @job_posting = JobPosting.find(params[:id])
    render json: @job_posting, serializer: JobPostingSerializer, root: false
  end

  private
  def job_posting_params
    params.require(:search).permit(:page, :q)
  end
end
