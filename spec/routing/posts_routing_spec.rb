require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/1/posts').to route_to('posts#index', user_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/users/1/posts/1').to route_to('posts#show', user_id: '1', id: '1')
    end
  end
end
