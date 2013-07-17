require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test "credit card validation" do
    assert_equal true, Card.credit_card_valid?("79927398713")
    assert_equal false, Card.credit_card_valid?("79927398714")

    assert_equal true, Card.credit_card_valid?("4485733360859658")
    assert_equal false, Card.credit_card_valid?("4485733360859651")
  end

  test "luhn number calc" do
    assert_equal "79927398713", Card.luhn_number("7992739871")
    assert_equal "4485733360859658", Card.luhn_number("448573336085965")
  end
end