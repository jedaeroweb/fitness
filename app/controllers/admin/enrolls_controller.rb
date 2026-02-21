class Admin::EnrollsController < Admin::OrdersController
  before_action :set_enroll, only: [:show, :edit, :update, :destroy]
  before_action :build_enroll_form, only: [:new, :create]
  before_action :load_user_from_params, only: [:new, :create]

  # GET /Users
  # GET /Users.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { :orders => { branch_id: session[:branch_id], enable: true } }

    @enroll_count = Enroll.joins(:order).where(condition).count
    @enrolls = Enroll.joins(:order).where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /Users/1
  # GET /Users/1.json
  def show
  end

  # GET /Users/new
  def new
    @enroll = Enroll.new
    build_enroll_form
  end

  # GET /Users/1/edit
  def edit
  end

  # POST /Users
  # POST /Users.json
  def create
    @enroll = Enroll.new(enroll_params)
    @enroll.order.branch_id=session[:branch_id]
    @enroll.order.last_transaction_date=@enroll.order.accounts[0].transaction_date
    @enroll.order.accounts[0].branch_id=session[:branch_id]
    @enroll.order.accounts[0].user_id=@enroll.order.user_id
    @enroll.order.accounts[0].account_category_id=1

    respond_to do |format|
      if @enroll.save
        format.html { redirect_to @enroll, notice: 'Gg was successfully created.' }
        format.json { render :show, status: :created, location: @enroll }
      else
        Rails.logger.debug @enroll.errors.full_messages
        Rails.logger.debug @enroll.errors.to_hash

        build_enroll_form

        format.html { render :new }
        format.json { render json: @enroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Users/1
  # PATCH/PUT /Users/1.json
  def update
    respond_to do |format|
      if @enroll.update(enroll_params)
        format.html { redirect_to @enroll, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @enroll }
      else
        format.html { render :edit }
        format.json { render json: @enroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Users/1
  # DELETE /Users/1.json
  def destroy
    @enroll.destroy
    respond_to do |format|
      format.html { redirect_to admin_enrolls_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def build_enroll_form
    @enroll.build_order unless @enroll.order
    @enroll.order.order_products.build if @enroll.order.order_products.empty?
    @enroll.order.accounts.build if @enroll.order.accounts.empty?
    @enroll.order.build_order_content unless @enroll.order.order_content
    @enroll.build_enroll_trainer unless @enroll.enroll_trainer
  end

  def load_user_from_params
    if params[:user_id].present?
      @user = User.find_by(id: params[:user_id], enable: true)
      @user_count = @user.present? ? 1 : 0
    else
      @user_count = 0
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_enroll
    @enroll = Enroll.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def enroll_params
    params.require(:enroll).permit(:quantity, :start_date, :end_date, order_attributes: [:user_id, order_products_attributes: [:product_id], accounts_attributes: [:transaction_date], order_content_attributes: [:content]], enroll_trainer_attributes: [:admin_id])

  end
end
