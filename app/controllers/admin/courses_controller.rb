class Admin::CoursesController < Admin::AdminController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { :products => { branch_id: session[:branch_id], enable: true } }

    @course_count = Course.joins(:product).where(condition).count
    @courses = Course.joins(:product).where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
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
