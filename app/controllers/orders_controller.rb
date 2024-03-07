class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: current_user.branch_id, enable: true }
    condition_sql='1=1'
    sql_params=[]

    if params[:start_date].present?
      condition_sql+=" AND transaction_date>=?"
      sql_params << params[:start_date].to_date
    end

    if params[:end_date].present?
      condition_sql+=" AND transaction_date<=?"
      sql_params << params[:end_date].to_date
    end

    @order_count = Order.where(condition).where(condition_sql,*sql_params).count()
    @orders = Order.where(condition).where(condition_sql,*sql_params).page(params[:page]).per(params[:per_page]).order('id desc');
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    params[:per_page] = 10 unless params[:per_page].present?

    @order = Order.new
    @order.orders_products.build

    @product_categories = ProductCategory.where({ branch_id: current_user.branch_id, enable: true })

    if params[:product_category]
      @product_category = ProductCategory.find(params[:product_category])
    else
      unless @product_categories.empty?
        @product_category = @product_categories.first
      end
    end

    if params[:search_type] and params[:search_word]
      if ['name', 'phone', 'access_card'].include?(params[:search_type])
        @users = User.where({ branch_id: current_user.branch_id, enable: true }).where("#{params[:search_type]} like ?", "%#{params[:search_word]}%")

        if @users.count == 1
          @user = @users[0];
        end
      end
    end

    @products = Product.where({ product_category_id: @product_category, branch_id: session[:branch_id], enable: true }).order('id desc').page(params[:page]).per(params[:per_page])
  end

  # GET /orders/1/edit
  def edit
  end

  def calculate_account(s, payment_method)
    a = { cash: 0, credit: 0, point: 0, total: 0 }
    if s.empty?
      return a
    end

    s.each do |ss|
      pp = ss.price * ss.quantity

      a[:total]+=pp
      case payment_method
      when 'cash'
        a[:cash]+=pp
      when 'credit'
        a[:credit]+=pp
      when 'point'
        a[:point]+=pp
      end
    end

    return a
  end

  # POST /orders
  # POST /orders.json
  def create
    result = false

    #begin

    @order = Order.new(order_params)
    @order.save!

    OrdersAdmin.create!(order_id: @order.id,admin_id: session[:admin_id])

    ca = calculate_account(@order.orders_products, params[:payment_method])
    account = Account.create!(account_category_id: 1, branch_id: session[:branch_id], user_id: @order.user_id, cash: ca[:cash], credit: ca[:credit], point: ca[:point])

    @order.orders_products.each do |order_product|
      @accounts_product=AccountsProduct.create!(:account_id=>account.id, :product_id=>order_product.product_id)
    end

    @accounts_order = AccountsOrder.create!(:account_id => account.id, :order_id => @order.id)
    @order.update(price: ca[:total], payment: ca[:total])

    if @accounts_order.save
      result = true
    end

    #rescue ActiveRecord::RecordInvalid => exception
    #  self.new
    #end

    respond_to do |format|
      if result
        format.html { redirect_to new_order_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:user_id, :transaction_date, :price, :discount, :payment, orders_products_attributes: [:id, :product_id, :price, :quantity]).merge(branch_id: session[:branch_id])
  end
end
