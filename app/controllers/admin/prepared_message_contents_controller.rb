class Admin::PreparedMessageContentsController < Admin::AdminController
  before_action :set_prepared_message_content, only: [:show, :edit, :update, :destroy]

  # GET /prepared_message_content/1
  # GET /prepared_message_content/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prepared_message_content
    @prepared_message_content = PreparedMessageContent.find(params[:id])
  end
end
