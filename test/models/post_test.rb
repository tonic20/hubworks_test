require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "generating permalink" do
    post = posts(:one)
    post.generate_permalink
    assert post.permalink, "one-title"
  end

  test "generating unique permalinks" do
    p1 = posts(:one)
    p1.generate_permalink
    p1.save

    p2 = posts(:duplicate)
    p2.generate_permalink
    p2.save

    assert_not_equal p1.permalink, p2.permalink
  end
end