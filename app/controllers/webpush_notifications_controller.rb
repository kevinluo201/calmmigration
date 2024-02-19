class WebpushNotificationsController < ApplicationController
  def create
    webpush_notification = WebpushNotification.find_or_create_by(
      p256dh: params[:keys][:p256dh],
      auth: params[:keys][:auth]
    )
    webpush_notification.update!(endpoint: params[:endpoint])
    render json: { status: :ok }
  end
end
