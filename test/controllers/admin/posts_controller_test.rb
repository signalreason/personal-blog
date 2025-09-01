require "test_helper"
require "helpers/auth_helper"

module Admin
  class PostsControllerTest < ActionDispatch::IntegrationTest
    include AuthHelper

    setup do
      @post = posts(:one)
    end

    test "should get new" do
      get new_admin_post_url, headers: { "HTTP_AUTHORIZATION" => auth_creds }
      assert_response :success
    end

    test "should create post" do
      assert_difference("Post.count") do
        post admin_posts_url, headers: { "HTTP_AUTHORIZATION" => auth_creds }, params: { post: { body_html: @post.body_html, body_md: @post.body_md, published_at: @post.published_at, slug: @post.slug, status: @post.status, summary: @post.summary, title: @post.title } }
      end

      assert_redirected_to post_url(Post.last)
    end

    test "should get edit" do
      get edit_admin_post_url(@post), headers: { "HTTP_AUTHORIZATION" => auth_creds }
      assert_response :success
    end

    test "should update post" do
      patch admin_post_url(@post), headers: { "HTTP_AUTHORIZATION" => auth_creds }, params: { post: { body_html: @post.body_html, body_md: @post.body_md, published_at: @post.published_at, slug: @post.slug, status: @post.status, summary: @post.summary, title: @post.title } }
      assert_redirected_to post_url(@post)
    end

    test "should destroy post" do
      assert_difference("Post.count", -1) do
        delete admin_post_url(@post), headers: { "HTTP_AUTHORIZATION" => auth_creds }
      end

      assert_redirected_to posts_url
    end
  end
end
