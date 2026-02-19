Rails.application.routes.draw do
  root 'home#index'

  resources :product_categories
  resources :products
  resources :trainers
  resources :exercises
  resources :messages
  resources :check_ins
  resources :pts
  resources :user_branches
  resources :user_weights

  devise_for :users, :controllers => {:omniauth_callbacks=>'users/omniauth_callbacks', :sessions => "users/sessions",:registrations => "users/registrations",:passwords => "users/passwords"}, :path_names =>  {:sign_up=>'new',:sign_in => 'login', :sign_out => 'logout'} do
    get 'edit', :to => 'users::Registrations#edit'
    get 'login', :to => 'users::Sessions#new'
    get 'logout', :to=> 'users::Sessions#destroy'
  end

  # 관리사용자
  devise_for :admins, :controllers => {:sessions => "admins/sessions",:registrations => "admins/registrations" }, :path_names =>  {:sign_up=>'new',:sign_in => 'login', :sign_out => 'logout'} do
    get 'edit', :to => 'admins::Registrations#edit'
    get 'login', :to => 'admins::Sessions#new'
    get 'logout', :to=> 'admins::Sessions#destroy'
  end

  # 관리자
  namespace :admin do
    root to: 'home#index'

    get 'home/settings', :to=>'home#settings', as: 'home_setting'
    get 'home/enrolls/:id', :to=>'home#enrolls', as: 'home_enrolls'
    get 'home/stops/:id', :to=>'home#stops', as: 'home_stops'
    get 'home/locker_rentals/:id', :to=>'home#locker_rentals', as: 'home_locker_rentals'
    get 'home/sports_wear_rentals/:id', :to=>'home#sports_wear_rentals', as: 'home_sports_wear_rentals'
    get 'home/check_ins/:id', :to=>'home#check_ins', as: 'home_check_ins'
    get 'home/accounts/:id', :to=>'home#accounts', as: 'home_accounts'
    get 'home/body_indexes/:id', :to=>'home#body_indexes', as: 'home_body_indexes'
    get 'home/memos/:id', :to=>'home#memos', as: 'home_memos'
    get 'home/counsels/:id', :to=>'home#counsels', as: 'home_counsels'
    get 'home/reservations/:id', :to=>'home#reservations', as: 'home_reservations'
    get 'home/messages/:id', :to=>'home#messages', as: 'home_messages'
    get 'users/select', :to=>'users#select', as: 'user_select'
    get 'temp_users/select', :to=>'temp_users#select', as: 'temp_user_select'
    get 'prepared_messages/select', :to=>'prepared_messages#select', as: 'prepared_message_select'
    get 'users', to: 'home#index', as: 'users'
    get 'webcam', to: 'webcam#index', as: 'webcam'

    get 'employees/users/:id', :to=>'employees#users', as: 'employee_users'
    get 'employees/memos/:id', :to=>'employees#memos', as: 'employee_memos'

    resources :user_pictures do
      collection do
        post :create_b64
      end
    end

    resources :admin_pictures do
      collection do
        post :create_b64
      end
    end

    resources :counsels
    resources :groups
    resources :users
    resources :user_contents
    resources :temp_users
    resources :check_ins
    resources :analysis
    resources :branches
    resources :reservations
    resources :accounts
    resources :product_categories
    resources :products
    resources :product_contents
    resources :course_categories
    resources :courses
    resources :locker_types
    resources :lockers
    resources :sports_wears
    resources :orders
    resources :searches
    resources :enrolls
    resources :locker_rentals
    resources :sports_wear_rentals
    resources :messages
    resources :message_contents
    resources :prepared_messages
    resources :prepared_message_contents
    resources :points
    resources :admins
    resources :employees, controller: "admins"
    resources :admins_users
    resources :notices
    resources :visit_routes
    resources :jobs
  end

end
