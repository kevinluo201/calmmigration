class Round < ApplicationRecord
  ROUND_BASE_URL = 'https://www.canada.ca/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html'
  GET_ROUNDS_JSON_URL = 'https://www.canada.ca/content/dam/ircc/documents/json/ee_rounds_4_en.json'

  attr_accessor :send_notifications_after_save

  after_commit :send_notifications, if: -> { send_notifications_after_save }

  def round_url
    ROUND_BASE_URL + "?q=#{number}"
  end

  def notification_message
    {
      title: "🇨🇦 Express Entry Round ##{number}",
      body: "Invitiation issues: #{ActiveSupport::NumberHelper.number_to_delimited(size)}, CRS: #{crs}, Type: #{name}, ",
      data: {
        url: 'https://calmmigration.ca'
      },
      tag: "express-entry-round-#{number}",
      icon: ActionController::Base.helpers.asset_url("logo.png")
    }
  end

  private

  def send_notifications
    WebpushNotification.send_notifications(notification_message)
  end
end
