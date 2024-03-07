class Admin::OrdersController < Admin::AdminController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /facilities
  # GET /facilities.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { :products => { branch_id: session[:branch_id], enable: true } }

    @facility_count = Facility.joins(:product).where(condition).count
    @facilities = Facility.joins(:product).where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
  end

  # GET /facilities/1/edit
  def edit
  end

  # POST /facilities
  # POST /facilities.json
  def create
    begin
      @product = Product.create!(product_category_id: params[:product_category_id], branch_id: session[:branch_id], title: params[:title], price: params[:price])
      ap = facility_params.merge(product_id: @product.id)
      result = @facility = Facility.create!(ap)

      respond_to do |format|
        if result
          format.html { redirect_to admin_facility_path(@facility), notice: 'Gg was successfully created.' }
          format.json { render :show, status: :created, location: @facility }
        else
          format.html { render :new }
          format.json { render json: @facility.errors, status: :unprocessable_entity }
        end
      end

    rescue ActiveRecord::RecordInvalid => exception
      flash[:alert] = exception.message
      redirect_to new_admin_facility_path
    end
  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    respond_to do |format|
      if @facility.update(facility_params)
        format.html { redirect_to @facility, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @facility }
      else
        format.html { render :edit }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    @facility.destroy
    respond_to do |format|
      format.html { redirect_to admin_facilities_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:product_id, :type, :order_no, :quantity, :start_no, :gender, :use_not_set, :enable).merge(admin_id: session[:admin_id], branch_id: session[:branch_id])
  end
end
