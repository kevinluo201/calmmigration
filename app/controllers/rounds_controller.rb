class RoundsController < ApplicationController
  def index
    @grid = RoundsGrid.new(grid_params) do |scope|
      scope.page(params[:page]).per(10)
    end
  end

  # GET /rounds/1 or /rounds/1.json
  def show
    @round = Round.find(params[:id])
  end

  protected

  def grid_params
    params.fetch(:rounds_grid, {}).permit!
  end
end
