# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
response = Faraday.get('https://www.canada.ca/content/dam/ircc/documents/json/ee_rounds_4_en.json')
rounds = JSON.parse(response.body)['rounds']
rounds.values.sort_by { |a| a['drawNumber'].to_i }.each do |round|
  a_round = Round.find_or_create_by(
    number: round['drawNumber'],
    name: round['drawName'],
    draw_at: DateTime.parse(round['drawDateTime']),
    size: round['drawSize'],
    minister: round['drawMinister'],
    crs: round['drawCRS'],
    tie_breaking_at: round['drawCutOff']
  )
end