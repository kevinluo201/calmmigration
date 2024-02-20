require "test_helper"

class WebpushNotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should post create" do
    post webpush_notifications_url, params: {
      endpoint: 'https://example.com',
      keys: {
        p256dh: 'p256dh',
        auth: 'auth'
      }
    }
    assert_response :success
    notification = WebpushNotification.last
    assert_equal 'https://example.com', notification.endpoint
    assert_equal 'p256dh', notification.p256dh
    assert_equal 'auth', notification.auth
  end
end
