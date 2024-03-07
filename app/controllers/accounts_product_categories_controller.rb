class AccountsProductCategoriesController < ApplicationController

  # GET /AccountProducts
  # GET /AccountProducts.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    if params[:product_category].present?
      @product_category=ProductCategory.find(params[:product_category])
    end

    condition={accounts: {branch_id: current_user.branch_id ,enable: true}}

    if @product_category.present?
      condition[:products]={product_category_id: @product_category.id}
    end

    @accounts_product_category_count=  AccountsProduct.includes(:account).includes(:product).where(condition).count
    @accounts_product_categories = AccountsProduct.includes(:account).includes(:product).select('accounts.*').where(condition).page(params[:page]).per(params[:per_page])

    @product_categories = ProductCategory.where({branch_id: current_user.branch_id, enable: true }).order('id desc')
  end

  # GET /AccountProducts/1
  # GET /AccountProducts/1.json
  def show
  end

  # GET /AccountProducts/new
  def new
    @accounts_product = AccountsProduct.new
  end

  # GET /AccountProducts/1/edit
  def edit
  end

  # POST /AccountProducts
  # POST /AccountProducts.json
  def create
    @accounts_product = AccountsProduct.new(accounts_product_params)

    respond_to do |format|
      if @accounts_product.save
        format.html { redirect_to @accounts_product, notice: 'Gg was successfully created.' }
        format.json { render :show, status: :created, location: @accounts_product }
      else
        format.html { render :new }
        format.json { render json: @accounts_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /AccountProducts/1
  # PATCH/PUT /AccountProducts/1.json
  def update
    respond_to do |format|
      if @account_product.update(accounts_product_params)
        format.html { redirect_to @account_product, notice: 'AccountProduct was successfully updated.' }
        format.json { render :show, status: :ok, location: @account_product }
      else
        format.html { render :edit }
        format.json { render json: @account_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /AccountProducts/1
  # DELETE /AccountProducts/1.json
  def destroy
    @accounts_product.destroy
    respond_to do |format|
      format.html { redirect_to account_products_url, notice: 'AccountProduct was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_accounts_product
    @accounts_product = AccountsProduct.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def accounts_product_params
    params.fetch(:AccountsProduct, {})
  end
end
