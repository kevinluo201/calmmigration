class WebpushNotification < ApplicationRecord
  def self.send_notifications(message)
    WebpushNotification.find_each do |notification|
      begin
        notification.send_message(message)
      rescue WebPush::ExpiredSubscription
        notification.destroy
      end
    end
  end

  def send_message(message)
    WebPush.payload_send(
      endpoint: endpoint,
      message: JSON.generate(message),
      p256dh: p256dh,
      auth: auth,
      vapid: {
        public_key: Rails.application.credentials.webpush.public_key,
        private_key: Rails.application.credentials.webpush.private_key
      }
    )
  end
end
