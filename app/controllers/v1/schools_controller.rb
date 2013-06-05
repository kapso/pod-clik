class V1::SchoolsController < ApplicationController
  # GET /v1/schools
  def index
    @schools = School.near(params[:lat], params[:lon])
    render json: @schools
  end

  # GET /v1/schools/:id
  def show
    @school = School.find params[:id]
    render json: @school
  end
end
