require 'rails_helper'

RSpec.describe "Posts", type: :feature do
  describe "GET /posts" do
    before (:example) do
      @user = User.create(name: 'John Doe', photo: 'live to photo', bio: 'live to bio')
      @post = Post.create(title: 'title', text: 'content', author: @user)
      visit user_posts_path(@user)
    end
    it "I can see the username" do
      expect(page).to have_content("content")
    end
  end
end