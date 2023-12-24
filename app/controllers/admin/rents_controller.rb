class Admin::RentsController < Admin::OrdersController
  before_action :set_rent, only: [:show, :edit, :update, :destroy]

  # GET /Users
  # GET /Users.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { :orders => { branch_id: session[:branch_id], enable: true } }

    @rent_count = Rent.joins(:order).where(condition).count
    @rents = Rent.joins(:order).where(condition).page(params[:page]).per(params[:per_page])
  end

  # GET /Users/1
  # GET /Users/1.json
  def show
  end

  # GET /Users/new
  def new
    @rent = Rent.new
    @rent.build_order
    @rent.order.order_products.build
    @rent.order.accounts.build
    @rent.order.build_order_content

    if params[:user_id].present?
      @user_count = User.where(id: params[:user_id], enable: true).count

      unless @user_count.zero?
        @user = User.where(id: params[:user_id], enable: true).first
      end
    else
      @user_count=0
    end
  end

  # GET /Users/1/edit
  def edit
  end

  # POST /Users
  # POST /Users.json
  def create
    @rent = Rent.new(rent_params)

    respond_to do |format|
      if @rent.save
        format.html { redirect_to @rent, notice: 'Gg was successfully created.' }
        format.json { render :show, status: :created, location: @rent }
      else
        if params[:rent][:order_attributes][:user_id].present?
          @user_count = User.where(id: params[:rent][:order_attributes][:user_id], enable: true).count

          unless @user_count.zero?
            @user = User.where(id: params[:rent][:order_attributes][:user_id], enable: true).first
          end
        else
          @user_count=0
        end

        format.html { render :new }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Users/1
  # PATCH/PUT /Users/1.json
  def update
    respond_to do |format|
      if @rent.update(rent_params)
        format.html { redirect_to @rent, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @rent }
      else
        format.html { render :edit }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Users/1
  # DELETE /Users/1.json
  def destroy
    @rent.destroy
    respond_to do |format|
      format.html { redirect_to admin_rents_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rent
    @rent = Rent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def rent_params
    params.require(:rent).permit(:quantity, :start_date, :end_date, order_attributes: [:user_id, order_products_attributes: [:product_id], accounts_attributes: [:transaction_date], order_content_attributes: [:content]], enroll_trainer_attributes: [:admin_id])
  end
end
