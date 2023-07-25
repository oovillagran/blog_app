require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #index' do
    before { get user_posts_path(user_id: 1) }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include('Here is the list of Posts for a given user')
    end
  end

  describe 'Get #show' do
    it 'returns a successful response' do
      get '/users/:user_id/posts/:id'
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get '/users/:user_id/posts/:id'
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users/:user_id/posts/:id'
      expect(response.body).to include('Here are the details of the Post')
    end
  end
end
