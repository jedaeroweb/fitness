class Admin::CoursesController < Admin::AdminController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    if params[:search_detail].present?
      session[:search_detail]=1
    else
      if params[:search_summary].present?
        session.delete(:search_detail)
      end
    end

    if params[:list_type].present?
      if params[:list_type]=='list'
        session[:course_list_type]='list'
      else
        session[:course_list_type]='module'
      end
    end

    condition = { branch_id: session[:branch_id], enable: true }

    @course_category_count=CourseCategory.where(condition).count
    @course_categories=CourseCategory.where(condition)

    params[:per_page] = 12 unless params[:per_page].present?

    if params[:category]
      @course_category = CourseCategory.find(params[:category])
    end

    condition = { :products => { branch_id: session[:branch_id], enable: true } }

    if @course_category.present?
      condition['products.product_category_id'] = @course_category.id
    end

    @course_count = Course.joins(:product).where(condition).count
    @courses = Course.joins(:product).where(condition).page(params[:page]).per(params[:per_page]).order('id desc')


    respond_to do |format|
      format.html # _slide.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /Users/1
  # GET /Users/1.json
  def show
  end

  # GET /Users/new
  def new
    @course = Course.new
    @course.build_product
    @course.product.build_product_content
  end

  # GET /Users/1/edit
  def edit
  end

  # POST /Users
  # POST /Users.json
  def create
    cc = course_params
    cc[:product_attributes].merge!({ branch_id: session[:branch_id] })

    @course = Course.create!(cc)

    respond_to do |format|
      if @course.save
        format.html { redirect_to admin_course_path(@course), notice: 'course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Users/1
  # PATCH/PUT /Users/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to admin_course_path(@course), notice: 'course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Users/1
  # DELETE /Users/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:order_no, :default_quantity, product_attributes: [:product_category_id, :title, :price, product_content_attributes: [:content]])
  end
end
