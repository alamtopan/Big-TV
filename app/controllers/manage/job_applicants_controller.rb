class Manage::JobApplicantsController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => JobApplicant, :collection_name => 'job_applicants', :instance_name => 'job_applicant'
  before_filter :select_jobs

  def index
    @job_applicants = JobApplicant.order('id ASC')
  end

  def download
  	job = JobApplicant.find(params[:id])
  	send_file job.file_resume.path, type: job.file_resume_content_type, disposition: 'attachment'
  end

  private
  	def select_jobs
  		@jobs = Job.order("id DESC")
  		@status	= ['Pending','Accepted','rejected'] 
  	end
end