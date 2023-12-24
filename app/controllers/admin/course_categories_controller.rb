class Admin::CourseCategoriesController < Admin::AdminController
  before_action :set_course_category, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }

    @course_category_count = CourseCategory.where(condition).count
    @course_categories = CourseCategory.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /Users/1
  # GET /Users/1.json
  def show
  end

  # GET /Users/new
  def new
    @course_category = CourseCategory.new
  end

  # GET /Users/1/edit
  def edit
  end

  # POST /Users
  # POST /Users.json
  def create
    @course_category = CourseCategory.new(course_category_params)

    respond_to do |format|
      if @course_category.save
        format.html { redirect_to admin_course_category_path(@course_category), notice: 'course category was successfully created.' }
        format.json { render :show, status: :created, location: @course_category }
      else
        format.html { render :new }
        format.json { render json: @course_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Users/1
  # PATCH/PUT /Users/1.json
  def update
    respond_to do |format|
      if @course_category.update(course_category_params)
        format.html { redirect_to admin_course_category_path(@course_category), notice: 'course category was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_category }
      else
        format.html { render :edit }
        format.json { render json: @course_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Users/1
  # DELETE /Users/1.json
  def destroy
    @course_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_course_categories_url, notice: 'course category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course_category
    @course_category = CourseCategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def course_category_params
    params.require(:course_category).permit(:title).merge(branch_id: session[:branch_id])
  end
end
