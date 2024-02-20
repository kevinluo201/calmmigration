class Round < ApplicationRecord
  ROUND_BASE_URL = 'https://www.canada.ca/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html'

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
