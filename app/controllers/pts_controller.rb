class PtsController < ApplicationController
  load_and_authorize_resource
  before_action :set_pt, only: [:show, :edit, :update, :destroy]

  # GET /Products
  # GET /Products.json
  def index
    condition = { enable: true }

    @pt_count = Enroll.where(condition).count
    @pts = Enroll.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /Products/1
  # GET /Products/1.json
  def show
  end

  # GET /Products/new
  def new
  end

  # GET /Products/1/edit
  def edit
  end

  # POST /Products
  # POST /Products.json
  def create
  end

  # PATCH/PUT /Products/1
  # PATCH/PUT /Products/1.json
  def update
  end

  # DELETE /Products/1
  # DELETE /Products/1.json
  def destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pt
    @pt = Enroll.find(params[:id])
  end
end
