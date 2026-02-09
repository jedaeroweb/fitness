class Admin::HomeController < Admin::AdminController
  def settings

  end

  def index
    common_index


    @memo_count = UserContent.where(user_id: @user, enable: true).count
    @memos = UserContent.where(user_id: @user, enable: true).order('id desc')
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
      @user_count = User.where(condition).where(condition_sql, '%' + params[:search_word].strip + '%').count
      @users = User.where(condition).where(condition_sql, '%' + params[:search_word].strip + '%').page(params[:page]).per(params[:per_page]).order('id desc')
    else
      @user_count = User.where(condition).count
      @users = User.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
    end

    @user = nil
    unless @user_count.zero?
      @user = @users[0]
      @user_additional = UserAdditional.find_by_user_id(@user.id)
    end
  end

  def enrolls
    common_index
  end

  def locker_rentals
    common_index
  end

  def stops
    common_index
  end

  def sports_wear_rentals
    common_index
  end

  def check_ins
    common_index

    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], user_id: @user.id, enable: true }

    @check_in_count = CheckIn.where(condition).count
    @check_ins = CheckIn.where(condition).page(params[:page]).per(params[:per_page])

    @check_in = CheckIn.new
  end

  def accounts
    common_index
  end

  def body_indexes
    common_index
  end

  def memos
    common_index

    params[:per_page] = 10 unless params[:per_page].present?

    condition = { 'users.branch_id': session[:branch_id], enable: true }

    @memo_count = UserContent.joins(:user).where(condition).count
    @memos = UserContent.joins(:user).where(condition).page(params[:page]).per(params[:per_page])
  end

  def reservations
    common_index
  end

  def counsels
    common_index
  end

  def messages
    common_index

    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], 'message_receivers.user_id': @user.id, enable: true }

    @message_count = Message.joins(:message_receivers).where(condition).count
    @messages = Message.joins(:message_receivers).where(condition).page(params[:page]).per(params[:per_page])
  end
end
