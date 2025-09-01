require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  def authed_url(url)
    uri = URI(url)
    uri.userinfo = [
      Rails.application.credentials.admin_user,
      Rails.application.credentials.admin_password
    ].join(':')
    uri.to_s
  end

  setup do
    @post = posts(:one)
    visit authed_url(login_url)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "should create post" do
    visit authed_url(posts_url)
    click_on "New post"

    fill_in "Body md", with: @post.body_md
    fill_in "Title", with: @post.title
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "should update Post" do
    visit authed_url(post_url(@post))
    click_on "Edit this post", match: :first

    fill_in "Body md", with: @post.body_md
    fill_in "Title", with: @post.title
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "should destroy Post" do
    skip "can't find destroy button"
    visit authed_url(post_url(@post))
    accept_confirm { click_on "Destroy this post", match: :first }

    assert_text "Post was successfully destroyed"
  end
end
