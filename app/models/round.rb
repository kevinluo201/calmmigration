class Round < ApplicationRecord
  ROUND_BASE_URL = 'https://www.canada.ca/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html'
  GET_ROUNDS_JSON_URL = 'https://www.canada.ca/content/dam/ircc/documents/json/ee_rounds_4_en.json'

  def round_url
    ROUND_BASE_URL + "?q=#{number}"
  end

  def notification_message
    {
      title: "Express Entry Round ##{number}",
      body: "Invitations issued: #{size}, CRS: #{crs}, Tie-breaking rule: #{tie_breaking_at}",
      data: {
        url: round_url
      },
      tag: "express-entry-round-#{number}"
    }
  end
end
