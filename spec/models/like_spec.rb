require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:example) do
    @user = User.create(name: 'John Doe', photo: 'live to photo', bio: 'live to bio', posts_counter: 0)
    @post = Post.create(title: 'title', text: 'content', author: @user, comments_counter: 0, likes_counter: 0)
    @like = Like.create(post: @post, author: @user)
  end

  it 'have correct user' do
    expect(@like.author_id).to eq(@user.id)
  end

  it 'have correct post' do
    expect(@like.post_id).to eq(@post.id)
  end

  it 'test if like counter is updated' do
    expect(@post.likes_counter).to eq 1
  end
end
