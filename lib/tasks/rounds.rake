namespace :rounds do
  desc "Polling to get the new rounds from the IRCC website."
  task poll: :environment do
    current_rounds = Round.pluck(:number)
    response = Faraday.get(Round::GET_ROUNDS_JSON_URL)
    rounds = JSON.parse(response.body)['rounds']
    rounds.values.reject do |r|
      current_rounds.include?(r['drawNumber'])
    end.sort_by { |a| a['drawNumber'].to_i }.each do |round|
      a_round = Round.find_or_initialize_by(number: round['drawNumber'])
      if a_round.new_record?
        a_round.assign_attributes(
          name: round['drawName'],
          draw_at: DateTime.parse(round['drawDateTime']),
          size: round['drawSize'],
          minister: round['drawMinister'],
          crs: round['drawCRS'],
          tie_breaking_at: round['drawCutOff']
        )
        a_round.send_notifications_after_save = true
        a_round.save!
      end
    end
  end
end
