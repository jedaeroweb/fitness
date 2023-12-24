class Admin::MessagesController < Admin::AdminController
  before_action :set_message, only: [:show, :update, :destroy]
  before_action :send_message

  def send_message

  end
  # GET /facilities
  # GET /facilities.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }

    @message_count = Message.where(condition).count
    @messages = Message.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
  end

  def new
    @message_send_types = MessageSendType.all

    @message_type='sms'

    @users = []
    @temp_users = []

    if params[:user_id]

    end

    if params[:temp_user_id]

    end

    @message = Message.new
    @message.build_message_content
  end

  # POST /facilities
  # POST /facilities.json
  def create
    @message_send_types = MessageSendType.all

    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to [:admin, @message], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to admin_messages_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:message_send_type_id, :title, :enable, message_content_attributes: [:content]).merge(branch_id: session[:branch_id])
  end
end
