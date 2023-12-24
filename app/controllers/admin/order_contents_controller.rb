class Admin::OrderContentsController < Admin::AdminController
  before_action :set_order_content, only: [:show, :edit, :update, :destroy]

  # GET /order_contents/new
  def new
    @order_content = OrderContent.new

    if params[:order_id].present?
      @order = Order.where(:id => params[:order_id], :enable => true).first
    end
  end

  # GET /order_contents/1
  # GET /order_contents/1.json
  def show
  end

  # POST /order_contents
  # POST /order_contents.json
  def create
    @order_content = OrderContent.new(user_content_params)

    respond_to do |format|
      if @order_content.save
        format.html { redirect_to [:admin, @order_content.user], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @order_content }
      else
        if params[:order_id].present?
          @user = Order.where(:id => params[:order_id], :enable => true).first
        end

        format.html { render action: 'new' }
        format.json { render json: @order_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_contents/1
  # DELETE /order_contents/1.json
  def destroy
    order_id=@order_content.order_id

    @order_content.destroy
    respond_to do |format|
      format.html { redirect_to admin_order_path(order_id), notice: 'order_content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_content
    @order_content = OrderContent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_content_params
    params.require(:order_content).permit(:order_id, :content, :enable)
  end
end
