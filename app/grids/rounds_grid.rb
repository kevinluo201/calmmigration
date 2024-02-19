class RoundsGrid < BaseGrid

  scope do
    Round.order(id: :desc)
  end

  filter(:name)
  filter(:draw_at, :date, range: true)

  column(:round_number, header: '#', order: false) do
    number
  end
  column(:draw_at, header: 'Date') do
    draw_at.strftime("%B %d, %Y")
  end
  column(:name, header: 'Round Type')
  column(:size, header: 'Invitations Issued')
  column(:crs, header: 'Lowest CRS')
end
