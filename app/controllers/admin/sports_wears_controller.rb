class Admin::SportsWearsController < Admin::ProductsController
  before_action :set_sport_wear, only: [:show, :edit, :update, :destroy]

  # GET /sport_wears
  # GET /sport_wears.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { products: { branch_id: session[:branch_id], enable: true } }

    @sports_wear_count = SportsWear.joins(:product).where(condition).count
    @sports_wears = SportsWear.joins(:product)
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
    @sports_wear = SportsWear.new
    @sports_wear.build_product
    @sports_wear.product.build_product_content
  end

  # GET /sport_wears/1/edit
  def edit
  end

  # POST /sport_wears
  # POST /sport_wears.json
  def create
    @sports_wear = SportsWear.new(sports_wear_params)

    if @sports_wear.product
      @sports_wear.product.branch_id = session[:branch_id]
    end

    respond_to do |format|
      if @sports_wear.save
        format.html { redirect_to admin_sports_wear_path(@sports_wear), notice: 'sport_wear was successfully created.' }
        format.json { render :show, status: :created, location: @sports_wear }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sports_wear.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sport_wears/1
  # PATCH/PUT /sport_wears/1.json
  def update
    respond_to do |format|
      if @sports_wear.update(sports_wear_params)
        format.html { redirect_to admin_sports_wear_path(@sports_wear), notice: 'sport_wear was successfully updated.' }
        format.json { render :show, status: :ok, location: @sports_wear }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sports_wear.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sport_wears/1
  # DELETE /sport_wears/1.json
  def destroy
    @sports_wear.destroy
    respond_to do |format|
      format.html { redirect_to admin_sports_wears_url, notice: 'sport_wear was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_sport_wear
    @sports_wear = SportsWear.find(params[:id])
  end

  def sports_wear_params
    params.require(:sports_wear).permit(:gender,
      product_attributes: [:id, :title, :price, :order_no]
    )
  end
end