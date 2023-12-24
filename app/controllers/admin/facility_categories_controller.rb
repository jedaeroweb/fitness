class Admin::FacilityCategoriesController < Admin::AdminController
  before_action :set_facility_category, only: [:show, :edit, :update, :destroy]

  # GET /facility_categories
  # GET /facility_categories.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }

    @facility_category_count = FacilityCategory.where(condition).count
    @facility_categories = FacilityCategory.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /facility_categories/1
  # GET /facility_categories/1.json
  def show
  end

  # GET /facility_categories/new
  def new
    @facility_category = FacilityCategory.new
  end

  # GET /facility_categories/1/edit
  def edit
  end

  # POST /facility_categories
  # POST /facility_categories.json
  def create
    @facility_category = FacilityCategory.new(course_category_params)

    respond_to do |format|
      if @facility_category.save
        format.html { redirect_to admin_course_category_path(@facility_category), notice: 'facility category was successfully created.'}
        format.json { render :show, status: :created, location: @facility_category }
      else
        format.html { render :new }
        format.json { render json: @facility_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facility_categories/1
  # PATCH/PUT /facility_categories/1.json
  def update
    respond_to do |format|
      if @facility_category.update(course_category_params)
        format.html { redirect_to admin_course_category_path(@facility_category), notice: 'facility category was successfully updated.'}
        format.json { render :show, status: :ok, location: @facility_category }
      else
        format.html { render :edit }
        format.json { render json: @facility_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_categories/1
  # DELETE /facility_categories/1.json
  def destroy
    @facility_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_course_categories_url, notice: 'facility category was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facility_category
    @facility_category = FacilityCategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def facility_category_params
    params.require(:facility_category).permit(:title).merge(branch_id: session[:branch_id])
  end
end
