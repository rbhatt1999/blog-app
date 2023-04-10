require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before(:example) do
    @user = User.create(name: 'John Doe',
                        photo: 'https://e7.pngegg.com/pngimages/636/141/png-clipart-computer-icons-user-s-included-miscellaneous-user-profile.png', bio: 'live to bio')
    @post = Post.create(title: 'title', text: 'content', author: @user)
    @comment = Comment.create(text: 'comment', post: @post, author: @user)
    @like = Like.create(post: @post, author: @user)
  end
  describe 'GET /users' do
    before(:example) do
      visit users_path
    end
    it 'I can see the username of all other users' do
      expect(page).to have_content('John Doe')
    end
    it 'I can see the profile picture of each user' do
      expect(page.find('img')['src']).to have_content @user.photo
    end
    it 'I can see the number of posts each user has' do
      expect(page).to have_content('Number of posts: 1')
    end
    it "When I click on a user's name I can see their posts" do
      find("a[href='/users/#{@user.id}'").click
      sleep 1
      expect(current_path).to eq user_path(@user)
    end
  end

  describe 'GET /users/:id' do
    before(:example) do
      visit user_path(@user)
    end
    it "I can see the user's profile picture" do
      expect(page.find('img')['src']).to have_content @user.photo
    end
    it "I can see the user's name" do
      expect(page).to have_content('John Doe')
    end
    it 'I can see the number of posts the user has' do
      expect(page).to have_content('Number of posts: 1')
    end
    it "I can see the user's bio" do
      expect(page).to have_content('live to bio')
    end
    it "I can see the user's first 3 posts" do
      @post2 = Post.create(title: 'title2', text: 'content2', author: @user)
      @post3 = Post.create(title: 'title3', text: 'content3', author: @user)
      @post4 = Post.create(title: 'title4', text: 'content4', author: @user)
      visit user_path(@user)
      expect(page.find_all('li h3').length).to eq(3)
    end
    it "I can see a button to see all of the user's posts" do
      expect(page.find(:xpath, '//button[1]').text).to eq('see all post')
    end
    it "When I click a user's post, it redirects me to that post's show page" do
      find("a[href='/users/#{@user.id}/posts/#{@post.id}']").click
      sleep 1
      expect(current_path).to eq user_post_path(@user, @post)
    end
    it "When I click the button to see all of the user's posts, it redirects me to a page with all of the user's posts" do
      find(:xpath, '//button[1]').click
      sleep 1
      expect(current_path).to eq user_posts_path(@user)
    end
  end
end
