class Admin::SportsWearsController < Admin::ProductsController
  before_action :set_sport_wear, only: [:show, :edit, :update, :destroy]

  # GET /sport_wears
  # GET /sport_wears.json
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
        session[:sports_wear_list_type]='list'
      else
        session[:sports_wear_list_type]='module'
      end
    end

    condition = { branch_id: session[:branch_id], enable: true }

    @sports_wear_category_count=SportsWearCategory.where(condition).count
    @sports_wear_categories=SportsWearCategory.where(condition)

    params[:per_page] = 12 unless params[:per_page].present?

    if params[:category]
      @sports_wear_category = SportsWearCategory.find(params[:category])
    end

    condition = { :products => { branch_id: session[:branch_id], enable: true } }

    if @sports_wear_category.present?
      condition['products.product_category_id'] = @sports_wear_category.id
    end

    @sports_wear_count = SportsWear.joins(:product).where(condition).count
    @sports_wears = SportsWear.joins(:product).where(condition).page(params[:page]).per(params[:per_page]).order('id desc')


    respond_to do |format|
      format.html # _slide.html.erb
      format.json { render json: @sports_wears }
    end
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