class Admin::JobsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
	before_action :require_is_admin
	layout "admin"
	def show
		@job = Job.find(params[:id])

		if @job.is_hidden
			flash[:waring] = "this job already archieved."
			redirect_to root_path
		end
	end

	def index
		@jobs = Job.all
	end

	def new
		@job = Job.new
	end

	def create
		@job = Job.new(job_params)
		if @job.save
			redirect_to admin_jobs_path
		else
			render :new
		end
	end

	def edit
		@job = Job.find(params[:id])
	end

	def update
		@job = Job.find(params[:id])
		if @job.update(job_params)
			redirect_to admin_jobs_path
		else
			render :edit
		end
	end

	def destroy
		@job = Job.find(params[:id])
		@job.destroy
		redirect_to admin_jobs_path
	end

	def public
		@job = Job.find(params[:id])
		@job.publish!
		redirect_to :back
	end

	def hide
		@job = Job.find(params[:id])
		@job.hide!
		redirect_to :back
	end

	private

	def job_params
		params.require(:job).permit(:title,:description, 
			:is_hidden, :wage_upper_bound, :wage_lower_bound, :contact_email)
	end
end
