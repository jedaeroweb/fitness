class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /Products
  # GET /Products.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @product_categories= ProductCategory.where({branch_id: current_admin.branch_id ,enable: true})


    if params[:product_category]
      @product_category=ProductCategory.find(params[:product_category])
    else
      unless @product_categories.empty?
        @product_category=@product_categories.first
      end
    end

    condition={product_category_id: @product_category,branch_id: current_admin.branch_id ,enable: true}

    @product_count = Product.where(condition).count()
    @products = Product.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /Products/1
  # GET /Products/1.json
  def show
  end

  # GET /Products/new
  def new
    @product = Product.new
    @product.build_product_picture

    @product_categories = ProductCategory.where({branch_id: current_admin.branch_id ,enable: true})
  end

  # GET /Products/1/edit
  def edit
  end

  # POST /Products
  # POST /Products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save!
        format.html { redirect_to @product, notice: 'Gg was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Products/1
  # PATCH/PUT /Products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Products/1
  # DELETE /Products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:product_category_id, :title, :price, product_picture_attributes: [:photo]).merge(branch_id: current_admin.branch_id)
  end
end
