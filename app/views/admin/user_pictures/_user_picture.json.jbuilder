json.extract! user_picture, :id, :user_id, :picture, :enable, :created_at, :updated_at
json.url admin_user_picture_url(user_picture, format: :json)
