class CreateWebpushNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :webpush_notifications do |t|
      t.string :endpoint
      t.string :p256dh
      t.string :auth

      t.timestamps
    end
  end
end
