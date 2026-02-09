class Admin::SportsWearsController < Admin::AdminController
  before_action :set_sport_wear, only: [:show, :edit, :update, :destroy]

  # GET /sport_wears
  # GET /sport_wears.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { products: { branch_id: session[:branch_id], enable: true } }

    @sport_wear_count = SportWear.joins(:product).where(condition).count
    @sport_wears = SportWear.joins(:product)
                            .where(condition)
                            .page(params[:page])
                            .per(params[:per_page])
                            .order('id desc')
  end

  # GET /sport_wears/1
  # GET /sport_wears/1.json
  def show
  end

  # GET /sport_wears/new
  def new
    @sport_wear = SportWear.new
    @sport_wear.build_product
    @sport_wear.product.build_product_content
  end

  # GET /sport_wears/1/edit
  def edit
  end

  # POST /sport_wears
  # POST /sport_wears.json
  def create
    cc = sport_wear_params
    cc[:product_attributes].merge!({ branch_id: session[:branch_id] })

    @sport_wear = SportWear.create!(cc)

    respond_to do |format|
      if @sport_wear.save
        format.html { redirect_to admin_sport_wear_path(@sport_wear), notice: 'sport_wear was successfully created.' }
        format.json { render :show, status: :created, location: @sport_wear }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sport_wear.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sport_wears/1
  # PATCH/PUT /sport_wears/1.json
  def update
    respond_to do |format|
      if @sport_wear.update(sport_wear_params)
        format.html { redirect_to admin_sport_wear_path(@sport_wear), notice: 'sport_wear was successfully updated.' }
        format.json { render :show, status: :ok, location: @sport_wear }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sport_wear.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sport_wears/1
  # DELETE /sport_wears/1.json
  def destroy
    @sport_wear.destroy
    respond_to do |format|
      format.html { redirect_to admin_sport_wears_url, notice: 'sport_wear was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_sport_wear
    @sport_wear = SportWear.find(params[:id])
  end

  def sport_wear_params
    params.require(:sport_wear).permit(
      :type, :order_no, :quantity, :start_no, :gender, :use_not_set,
      product_attributes: [
        :product_category_id, :title, :price,
        { product_content_attributes: [:content] }
      ]
    )
  end
end