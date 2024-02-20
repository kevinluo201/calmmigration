class WebpushNotification < ApplicationRecord
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
