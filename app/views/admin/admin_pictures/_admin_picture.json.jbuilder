json.extract! admin_picture, :id, :admin_id, :picture, :enable, :created_at, :updated_at
json.url admin_admin_picture_url(admin_picture, format: :json)
