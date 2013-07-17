require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  THREADS_COUNT = 10

  test "payment with optimistic lock" do
    threads = []
    THREADS_COUNT.times do
      threads << Thread.new do
        Payment.with_optimistic(service_id: 1, line_item_id: 1) do |payment|
          payment.amount += 1
        end
      end
    end
    threads.each {|t| t.join }
    assert_equal THREADS_COUNT, payments(:one).amount
    assert_equal THREADS_COUNT, payments(:one).lock_version
  end

  test "payment with pessimistic lock" do
    threads = []
    THREADS_COUNT.times do
      threads << Thread.new do
        Payment.with(service_id: 2, line_item_id: 2) do |payment|
          payment.amount += 1
        end
      end
    end
    threads.each {|t| t.join }
    assert_equal THREADS_COUNT, payments(:two).amount
  end
end