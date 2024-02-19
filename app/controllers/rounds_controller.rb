class RoundsController < ApplicationController
  # GET /rounds or /rounds.json
  def index
    @rounds = Round.all.order(id: :desc).page(params[:page]).per(10)
  end

  # GET /rounds/1 or /rounds/1.json
  def show
    @round = Round.find(params[:id])
  end
end
