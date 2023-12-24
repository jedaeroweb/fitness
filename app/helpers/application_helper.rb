module ApplicationHelper
  def add_hyphen(phone)
    phone
  end

  def current_controller(aa)
    if aa.include?(params[:controller])
      return 'class="current"'
    end
  end

  def manage_width(model)
    if can?(:delete, model) and can?(:update, model)
      return ' style=width:170px;'
    else
      return ' style=width:90px'
    end
  end

  def display_payment_method(accounts)
    payment_method=[]

    accounts.each do |account|
      unless account.cash.zero?
        payment_method.push(t(:cash));
      end

      unless account.credit.zero?
        payment_method.push(t(:credit));
      end

      unless account.point.zero?
        payment_method.push(t(:point));
      end
    end

    return payment_method.uniq.join(',')
  end

  def user_search_type_check(type, default=false)
    if default
      match=true
    else
      match=false;
    end

    if params[:user_search_type]
      if params[:user_search_type]==type
        match=true
      else
        match=false
      end
    end

    if match
      return 'checked="checked"'
    else
      return ''
    end
  end

  def get_nav_active_class(match_action,default_class='nav-link',active_class='active')
    return_class=default_class

    if match_action.kind_of?(Array)
      if match_action.include? params[:action]
        return_class+=' '+active_class
      end
    else
      if(params[:action]==match_action)
        return_class+=' '+active_class
      end
    end

    return return_class
  end

  def get_dt_format(date)
    return I18n.l date.to_date
  end

  def user_search_type_check(type, default=false)
    if default
      match=true
    else
      match=false;
    end

    if params[:user_search_type]
      if params[:user_search_type]==type
        match=true
      else
        match=false
      end
    end

    if match
      return 'checked="checked"'
    else
      return ''
    end
  end
end
