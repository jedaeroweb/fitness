class Admin::ProductContentsController < Admin::AdminController
  before_action :set_product_content, only: [:show, :edit, :update, :destroy]

  # GET /user_content/new
  def new
    @product_content = ProductContent.new

    if params[:product_id].present?
      @product = Product.where(:id => params[:product_id], :enable => true).first
    end
  end

  # GET /product_contents/1
  # GET /product_contents/1.json
  def show
  end

  def edit
  end

  # POST /order_contents
  # POST /order_contents.json
  def create
    @product_content = ProductContent.new(product_content_params)

    respond_to do |format|
      if @product_content.save
        format.html { redirect_to [:admin, @product_content.user], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @product_content }
      else
        if params[:product_id].present?
          @product = Product.where(:id => params[:product_id], :enable => true).first
        end

        format.html { render action: 'new' }
        format.json { render json: @product_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_contens/1
  # PATCH/PUT /product_contens/1.json
  def update
    respond_to do |format|
      if @product_content.update(product_content_params)
        format.html { redirect_to admin_product_conten_path(@product_content), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_content }
      else
        format.html { render :edit }
        format.json { render json: @product_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_content/1
  # DELETE /user_content/1.json
  def destroy
    product_id = @product_content.product_id

    @product_content.destroy
    respond_to do |format|
      format.html { redirect_to admin_product_path(product_id), notice: 'product_content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product_content
    @product_content = ProductContent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_content_params
    params.require(:product_content).permit(:product_id, :content, :enable)
  end
end
