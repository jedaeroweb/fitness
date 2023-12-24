class Admin::MessageContentsController < Admin::AdminController
  before_action :set_message_content, only: [:show, :edit, :update, :destroy]

  # GET /message_contents/1
  # GET /message_contents/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message_content
    @message_content = MessageContent.find(params[:id])
  end
end
