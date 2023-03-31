require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:example) do
    @user = User.create(name: 'John Doe', photo: 'live to photo', bio: 'live to bio', posts_counter: 0)
    @post = Post.create(title: 'title', text: 'content', author: @user, comments_counter: 0, likes_counter: 0)
    @comment = Comment.create(text: 'comment', post: @post, author: @user)
  end

  it 'have correct user' do
    expect(@comment.author_id).to eq(@user.id)
  end

  it 'have correct post' do
    expect(@comment.post_id).to eq(@post.id)
  end

  it 'test if comment counter is updated' do
    Comment.create(text: 'comment_1', post: @post, author: @user)
    expect(@post.comments_counter).to eq 2
  end
end
