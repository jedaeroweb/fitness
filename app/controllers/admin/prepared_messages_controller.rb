class Admin::PreparedMessagesController < Admin::AdminController
  before_action :set_prepared_message, only: [:show, :edit, :update, :destroy]

  # GET /facilities
  # GET /facilities.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }

    @prepared_message_count = PreparedMessage.where(condition).count
    @prepared_messages = PreparedMessage.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
  end

  # GET /facilities/new
  def new
    @prepared_message = PreparedMessage.new
    @prepared_message.build_prepared_message_content
  end

  # GET /facilities/1/edit
  def edit
  end

  # POST /facilities
  # POST /facilities.json
  def create
    @prepared_message = PreparedMessage.new(prepared_message_params)

    respond_to do |format|
      if @prepared_message.save
        format.html { redirect_to [:admin, @prepared_message], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @prepared_message }
      else
        format.html { render action: 'new' }
        format.json { render json: @prepared_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    respond_to do |format|
      if @prepared_message.update(prepared_message_params)
        format.html { redirect_to [:admin, @prepared_message], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @prepared_message }
      else
        format.html { render :edit }
        format.json { render json: @prepared_message.errors, status: :unprocessable_entity }
      end
    end
  end

  def select
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }

    @prepared_message_count = PreparedMessage.where(condition).count
    @prepared_messages = PreparedMessage.where(condition).page(params[:page]).per(params[:per_page])
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    @prepared_message.destroy
    respond_to do |format|
      format.html { redirect_to admin_prepared_messages_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prepared_message
    @prepared_message = PreparedMessage.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def prepared_message_params
    params.require(:prepared_message).permit(:title, :enable, prepared_message_content_attributes: [:content]).merge(branch_id: session[:branch_id])
  end
end
