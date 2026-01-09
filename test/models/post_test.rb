require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "status must be draft or published" do
    post = Post.new(title: "Hello", body_md: "Body", status: "archived")

    assert_not post.valid?
    assert_includes post.errors[:status], "is not included in the list"
  end

  test "publishing a post sets published_at when blank" do
    post = Post.create!(title: "Hello", body_md: "Body", status: "draft")

    assert_nil post.published_at

    post.update!(status: "published")
    assert_not_nil post.published_at
  end
end
