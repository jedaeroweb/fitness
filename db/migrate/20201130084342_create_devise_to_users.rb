class CreateDeviseToUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.references :branch, null: false
      t.string :name, null: false, limit: 60
      t.string :encrypted_password, null: false, limit: 60
      t.string :email, limit: 60
      t.string :phone, limit: 20
      t.date :birthday
      t.boolean :gender

      ## Recoverable
      # t.string   :reset_password_token, :limit=>150
      # t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      #t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      #t.string   :unlock_token # Only if unlock strategy is :email or :both
      #t.datetime :locked_at

      ## Token authenticatable
      ## t.string :authentication_token

      t.date :registration_date, null: false
      t.integer :orders_count, null: false, default: 0
      t.integer :accounts_count, null: false, default: 0
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :phone, unique: true
  end
end
