# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
response = Faraday.get(Round::GET_ROUNDS_JSON_URL)
rounds = JSON.parse(response.body)['rounds']
rounds.values.sort_by { |a| a['drawNumber'].to_i }.each do |round|
  a_round = Round.find_or_initialize_by(number: round['drawNumber'])
  if a_round.new_record?
    a_round.assign_raw_round(round)
    a_round.save!
  end
end

LevelPlan.find_or_create_by!(year: 2023) do |level_plan|
  level_plan.target = 82880
  level_plan.source = 'https://www.canada.ca/en/immigration-refugees-citizenship/news/notices/supplementary-immigration-levels-2023-2025.html'
  level_plan.save!
end
LevelPlan.find_or_create_by!(year: 2024) do |level_plan|
  level_plan.target = 109020
  level_plan.source = 'https://www.canada.ca/en/immigration-refugees-citizenship/news/notices/supplementary-immigration-levels-2023-2025.html'
  level_plan.save!
end
LevelPlan.find_or_create_by!(year: 2025) do |level_plan|
  level_plan.target = 114000
  level_plan.source = 'https://www.canada.ca/en/immigration-refugees-citizenship/news/notices/supplementary-immigration-levels-2023-2025.html'
  level_plan.save!
end
