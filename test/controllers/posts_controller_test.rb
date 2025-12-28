require "test_helper"
require "helpers/auth_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include AuthHelper

  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "when authenticated, should get new" do
    get new_post_url, headers: { "HTTP_AUTHORIZATION" => auth_creds }
    assert_response :success
  end

  test "when authenticated, should create post" do
    assert_difference("Post.count") do
      post posts_url, headers: { "HTTP_AUTHORIZATION" => auth_creds }, params: { post: { body_html: @post.body_html, body_md: @post.body_md, published_at: @post.published_at, slug: @post.slug, status: @post.status, summary: @post.summary, title: @post.title } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "when authenticated, should get edit" do
    get edit_post_url(@post), headers: { "HTTP_AUTHORIZATION" => auth_creds }
    assert_response :success
  end

  test "when authenticated, should update post" do
    patch post_url(@post), headers: { "HTTP_AUTHORIZATION" => auth_creds }, params: { post: { body_html: @post.body_html, body_md: @post.body_md, published_at: @post.published_at, slug: @post.slug, status: @post.status, summary: @post.summary, title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test "when authenticated, should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post), headers: { "HTTP_AUTHORIZATION" => auth_creds }
    end

    assert_redirected_to posts_url
  end
end
