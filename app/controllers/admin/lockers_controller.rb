class Admin::LockersController < Admin::ProductsController
  before_action :set_locker, only: [:show, :edit, :update, :destroy]

  # GET /lockers
  # GET /lockers.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { products: { branch_id: session[:branch_id], enable: true } }

    @locker_count = Locker.joins(:product).where(condition).count
    @lockers = Locker.joins(:product).where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /lockers/1
  # GET /lockers/1.json
  def show
  end

  # GET /lockers/new
  def new
    @locker = Locker.new
    @locker.build_product
    @locker.product.build_product_content
  end

  # GET /lockers/1/edit
  def edit
  end

  # POST /lockers
  # POST /lockers.json
  def create
    cc = locker_params
    cc[:product_attributes].merge!({ branch_id: session[:branch_id] })

    @locker = Locker.create!(cc)

    respond_to do |format|
      if @locker.save
        format.html { redirect_to admin_locker_path(@locker), notice: 'locker was successfully created.' }
        format.json { render :show, status: :created, location: @locker }
      else
        format.html { render :new }
        format.json { render json: @locker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lockers/1
  # PATCH/PUT /lockers/1.json
  def update
    respond_to do |format|
      if @locker.update(locker_params)
        format.html { redirect_to admin_locker_path(@locker), notice: 'locker was successfully updated.' }
        format.json { render :show, status: :ok, location: @locker }
      else
        format.html { render :edit }
        format.json { render json: @locker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lockers/1
  # DELETE /lockers/1.json
  def destroy
    @locker.destroy
    respond_to do |format|
      format.html { redirect_to admin_lockers_url, notice: 'locker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_locker
    @locker = Locker.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def locker_params
    params.require(:locker).permit(
      :type, :order_no, :quantity, :start_no, :gender, :use_not_set,
      product_attributes: [
        :product_category_id, :title, :price,
        { product_content_attributes: [:content] }
      ]
    )
  end
end