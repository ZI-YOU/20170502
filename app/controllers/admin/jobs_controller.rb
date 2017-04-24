class Admin::JobsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
	before_action :require_is_admin

	def show
		@job = find(params[:id])
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

	private

	def job_params
		params.require.(:jobs).permit(:title,:description, :wage_upper_bound, :wage_lower_bound, :contact_email)
	end
end
