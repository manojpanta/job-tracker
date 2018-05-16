# app/controllers/jobs_controller
class JobsController < ApplicationController
  def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
    elsif params[:sort] == 'location'
      @jobs = Job.sort_by_location
    else
      @jobs = Job.all
    end
  end

  def new
    @categories = Category.all
    @company = Company.find(params[:company_id])
    @job = Job.new
  end

  def create
    @categories = Category.all
    @company = Company.find(params[:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      render :new
    end
  end

  def show
    @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
    @comment = Comment.new
    @comments = @job.comments.order('created_at DESC')
  end

  def edit
    @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    @job.update(job_params)
    if @job.save
      flash[:success] = "#{@job.title} updated!"
      redirect_to company_job_path(@company = Company.find(@job.company_id), @job)
    else
      render :edit
    end
  end

  def destroy
    @job = Job.destroy(params[:id])
    flash[:success] = "#{@job.title} deleted!"
    redirect_to company_jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
  end
end
