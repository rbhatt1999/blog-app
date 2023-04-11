require 'rails_helper'

RSpec.describe '/posts', type: :request do
  describe 'GET /index' do
    before(:example) do
      @user = User.create(name: 'John Doe', photo: 'live to photo', bio: 'live to bio')
      @post = Post.create(title: 'title', text: 'content', author: @user)
      get user_posts_path(@user)
    end
    it 'renders a successful response' do
      expect(response).to be_successful
    end
    it 'correctly renders the index template' do
      expect(response).to render_template(:index)
    end
    it 'contain the placeholder text' do
      expect(response.body).to include('John Doe')
    end
  end

  describe 'GET /show' do
    before(:example) do
      @user = User.create(name: 'John Doe', photo: 'live to photo', bio: 'live to bio')
      @post = Post.create(title: 'title', text: 'content', author: @user)
      get user_post_path(@user, @post)
    end
    it 'renders a successful response' do
      expect(response).to be_successful
    end
    it 'correctly renders the show template' do
      expect(response).to render_template(:show)
    end
    it 'contain the placeholder text' do
      expect(response.body).to include('content')
    end
  end
end
