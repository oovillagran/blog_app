require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    before { get users_path }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include('Here is a list of Users')
    end
  end

  describe 'Get #show' do
    it 'returns a successful response' do
      get '/users/:id'
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get '/users/:id'
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users/:id'
      expect(response.body).to include('Here are the details of the user')
    end
  end
end
