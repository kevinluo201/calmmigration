class LevelPlan < ApplicationRecord
  def self.current
    LevelPlan.find_by(year: Date.current.year)
  end

  def total_invitations
    @total_invitations ||= Round.where(draw_at: Date.new(year, 1, 1)...Date.new(year + 1, 1, 1)).sum(:size)
  end
end
