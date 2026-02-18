class Admin::EmployeesController < Admin::AdminController
  def index
    common_index

  end

  def common_index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }
    like = false

    if params[:search_field].present? and params[:search_word].present?
      case params[:search_field]
      when 'name'
        condition_sql = 'name like ?'
        like = true
      when 'phone'
        condition_sql = 'phone like ?'
        like = true
      end
    end

    if like
      @admin_count = Admin.where(condition).where(condition_sql, '%' + params[:search_word].strip + '%').count
      @admins = Admin.where(condition).where(condition_sql, '%' + params[:search_word].strip + '%').page(params[:page]).per(params[:per_page]).order('id desc')
    else
      @admin_count = Admin.where(condition).count
      @admins = Admin.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
    end

    @admin = nil
    unless @admin_count.zero?
      @admin = @admins[0]
    end
  end

  def users
    common_index
  end

  def memos
    common_index

    params[:per_page] = 10 unless params[:per_page].present?

    condition = { 'admins.branch_id': session[:branch_id], enable: true }

    @memo_count = AdminContent.joins(:admin).where(condition).count
    @memos = AdminContent.joins(:admin).where(condition).page(params[:page]).per(params[:per_page])
  end

end
