class RoundsGrid < BaseGrid

  scope do
    Round.order(id: :desc)
  end

  filter(:name)
  filter(:draw_at, :date, range: true)

  column(:number)
  date_column(:draw_at)
  column(:name)
  column(:size)
  column(:crs)
end
