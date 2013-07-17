class Card
  def self.credit_card_valid?(card_number)
    card_number == Card.luhn_number(card_number[0..-2])
  end

  def self.luhn_number(number)
    digits = number.chars.map(&:to_i)
    sum = digits.reverse.each_slice(2).map do |x, y|
      [(x * 2).divmod(10), y]
    end.flatten.compact.inject(:+)
    number + (10 - sum % 10).to_s
  end
end