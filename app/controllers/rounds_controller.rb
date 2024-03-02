class RoundsController < ApplicationController
  def index
    @level_plan = LevelPlan.current
    @grid = RoundsGrid.new(grid_params) do |scope|
      scope.page(params[:page]).per(10)
    end
  end

  protected

  def grid_params
    params.fetch(:rounds_grid, {}).permit!
  end
end
