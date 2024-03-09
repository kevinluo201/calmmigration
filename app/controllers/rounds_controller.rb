class RoundsController < ApplicationController
  def index
    @level_plan = LevelPlan.current
    @grid = RoundsGrid.new(grid_params) do |scope|
      scope.page(params[:page]).per(25)
    end
  end

  def trends
    @rounds = Round.all
  end

  protected

  def grid_params
    params.fetch(:rounds_grid, {}).permit!
  end
end
