class Admin::CounselsController < Admin::AdminController
  before_action :set_counsel, only: [:show, :edit, :update, :destroy]

  # GET /counsels
  # GET /counsels.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { :products => { branch_id: session[:branch_id], enable: true } }

    @counsel_count = Counsel.joins(:product).where(condition).count
    @counsels = Counsel.joins(:product).where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /counsels/1
  # GET /counsels/1.json
  def show
  end

  # GET /counsels/new
  def new
    @counsel = Counsel.new
  end

  # GET /counsels/1/edit
  def edit
  end

  # POST /counsels
  # POST /counsels.json
  def create
    @counsel = Counsel.new(counsel_params)

    respond_to do |format|
      if @counsel.save
        format.html { redirect_to @counsel, notice: 'Counsel was successfully created.' }
        format.json { render :show, status: :created, location: @counsel }
      else
        format.html { render :new }
        format.json { render json: @counsel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /counsels/1
  # PATCH/PUT /counsels/1.json
  def update
    respond_to do |format|
      if @counsel.update(counsel_params)
        format.html { redirect_to @counsel, notice: 'Counsel was successfully updated.' }
        format.json { render :show, status: :ok, location: @counsel }
      else
        format.html { render :edit }
        format.json { render json: @counsel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counsels/1
  # DELETE /counsels/1.json
  def destroy
    @counsel.destroy
    respond_to do |format|
      format.html { redirect_to admin_counsels_url, notice: 'Counsel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_counsel
    @counsel = Counsel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def counsel_params
    params.require(:counsel).permit(:title).merge(admin_id: current_admin.id, branch_id: session[:branch_id])
  end
end
