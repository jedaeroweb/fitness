class Admin::LockerRentalsController < Admin::OrdersController
  before_action :set_locker_rental, only: [:show, :edit, :update, :destroy]

  # GET /Users
  # GET /Users.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { :orders => { branch_id: session[:branch_id], enable: true } }

    @locker_rental_count = LockerRental.joins(:order).where(condition).count
    @locker_rentals = LockerRental.joins(:order).where(condition).page(params[:page]).per(params[:per_page])
  end

  # GET /Users/1
  # GET /Users/1.json
  def show
  end

  # GET /Users/new
  def new
    @locker_rental = LockerRental.new
    @locker_rental.build_order
    @locker_rental.order.order_products.build
    @locker_rental.order.accounts.build
    @locker_rental.order.build_order_content

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
    @locker_rental = LockerRental.new(locker_rental_params)

    respond_to do |format|
      if @locker_rental.save
        format.html { redirect_to @locker_rental, notice: 'Gg was successfully created.' }
        format.json { render :show, status: :created, location: @locker_rental }
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
        format.json { render json: @locker_rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Users/1
  # PATCH/PUT /Users/1.json
  def update
    respond_to do |format|
      if @locker_rental.update(locker_rental_params)
        format.html { redirect_to @locker_rental, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @locker_rental }
      else
        format.html { render :edit }
        format.json { render json: @locker_rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Users/1
  # DELETE /Users/1.json
  def destroy
    @locker_rental.destroy
    respond_to do |format|
      format.html { redirect_to admin_rents_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_locker_rental
    @locker_rental = LockerRental.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def locker_rental_params
    params.require(:locker_rental).permit(:quantity, :start_date, :end_date, order_attributes: [:user_id, order_products_attributes: [:product_id], accounts_attributes: [:transaction_date], order_content_attributes: [:content]], enroll_trainer_attributes: [:admin_id])
  end
end
