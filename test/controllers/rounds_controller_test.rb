require "test_helper"

class RoundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @round = rounds(:one)
  end

  test "should get index" do
    get rounds_url
    assert_response :success
  end

  test "should get new" do
    get new_round_url
    assert_response :success
  end

  test "should create round" do
    assert_difference("Round.count") do
      post rounds_url, params: { round: { crs: @round.crs, draw_at: @round.draw_at, minister: @round.minister, name: @round.name, number: @round.number, size: @round.size, tie_breaking_at: @round.tie_breaking_at } }
    end

    assert_redirected_to round_url(Round.last)
  end

  test "should show round" do
    get round_url(@round)
    assert_response :success
  end

  test "should get edit" do
    get edit_round_url(@round)
    assert_response :success
  end

  test "should update round" do
    patch round_url(@round), params: { round: { crs: @round.crs, draw_at: @round.draw_at, minister: @round.minister, name: @round.name, number: @round.number, size: @round.size, tie_breaking_at: @round.tie_breaking_at } }
    assert_redirected_to round_url(@round)
  end

  test "should destroy round" do
    assert_difference("Round.count", -1) do
      delete round_url(@round)
    end

    assert_redirected_to rounds_url
  end
end
