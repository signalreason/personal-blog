require "test_helper"
require "helpers/auth_helper"

class PublishedPostsControllerTest < ActionDispatch::IntegrationTest
  include AuthHelper

  setup do
    @published_post = Post.create!(
      title: "Published",
      slug: "published",
      body_md: "Body",
      status: "published",
      published_at: 1.day.ago
    )
    @draft_post = Post.create!(
      title: "Draft",
      slug: "draft",
      body_md: "Body",
      status: "draft"
    )
    @scheduled_post = Post.create!(
      title: "Scheduled",
      slug: "scheduled",
      body_md: "Body",
      status: "published",
      published_at: 1.day.from_now
    )
  end

  test "index shows only published posts to public" do
    get posts_url
    assert_response :success
    assert_select "td a", text: @published_post.title
    assert_select "td a", text: @draft_post.title, count: 0
    assert_select "td a", text: @scheduled_post.title, count: 0
  end

  test "show returns 404 for non-published posts to public" do
    get post_url(@published_post)
    assert_response :success

    get post_url(@draft_post)
    assert_response :not_found

    get post_url(@scheduled_post)
    assert_response :not_found
  end

  test "admin can view all posts on index and show" do
    get login_url, headers: { "HTTP_AUTHORIZATION" => auth_creds }

    get posts_url
    assert_response :success
    assert_select "td a", text: @published_post.title
    assert_select "td a", text: @draft_post.title
    assert_select "td a", text: @scheduled_post.title

    get post_url(@draft_post)
    assert_response :success
  end
end
