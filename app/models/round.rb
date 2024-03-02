class Round < ApplicationRecord
  ROUND_BASE_URL = 'https://www.canada.ca/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html'
  GET_ROUNDS_JSON_URL = 'https://www.canada.ca/content/dam/ircc/documents/json/ee_rounds_4_en.json'

  attr_accessor :send_notifications_after_save

  after_commit :send_notifications, if: -> { send_notifications_after_save }

  def assign_raw_round(raw_round)
    assign_attributes(
      number: raw_round['drawNumber'],
      name: raw_round['drawName'],
      draw_at: DateTime.parse(raw_round['drawDateTime']),
      size: raw_round['drawSize'].delete(',').to_i,
      minister: raw_round['drawMinister'],
      crs: raw_round['drawCRS'],
      tie_breaking_at: raw_round['drawCutOff']
    )
  end

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
