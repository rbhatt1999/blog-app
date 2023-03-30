require 'rails_helper'

RSpec.describe User, type: :model do
  before(:example) do
    @user = User.create(name: 'John Doe', photo: 'live to photo', bio: 'live to bio', posts_counter: 0)
  end

  it 'name is invalid' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'posts_counter is invalid' do
    @user.posts_counter = 'asdasdasd'
    expect(@user).to_not be_valid
  end

  it 'post counter is integer' do
    @user.posts_counter = -1
    expect(@user).to_not be_valid
  end

  it 'recent_posts should return 3 posts' do
    Post.create(title: 'title', text: 'content', author: @user, comments_counter: 0, likes_counter: 0)
    Post.create(title: 'title_1', text: 'content_1', author: @user, comments_counter: 0, likes_counter: 0)
    Post.create(title: 'title_2', text: 'content_2', author: @user, comments_counter: 0, likes_counter: 0)
    Post.create(title: 'title_3', text: 'content_3', author: @user, comments_counter: 0, likes_counter: 0)
    expect(@user.recent_posts.count).to eq(3)
  end
end
