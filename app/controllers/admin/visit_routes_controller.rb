class Admin::VisitRoutesController < Admin::AdminController
  before_action :set_visit_route, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { enable: true }

    @visit_route_count = VisitRoute.where(condition).count
    @visit_routes = VisitRoute.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  def show

  end

  # GET /groups/new
  def new
    @visit_route = VisitRoute.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @visit_route = VisitRoute.new(visit_route_params)

    respond_to do |format|
      if @visit_route.save
        format.html { redirect_to [:admin, @visit_route], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @visit_route }
      else
        format.html { render action: 'new' }
        format.json { render json: @visit_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @visit_route.update(visit_route_params)
        format.html { redirect_to admin_visit_route_path(@visit_route), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @visit_route }
      else
        format.html { render :edit }
        format.json { render json: @visit_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @visit_route.destroy
    respond_to do |format|
      format.html { redirect_to admin_visit_routes_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_visit_route
    @visit_route = VisitRoute.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def visit_route_params
    params.require(:visit_route).permit(:title, :description, :enable)
  end
end
