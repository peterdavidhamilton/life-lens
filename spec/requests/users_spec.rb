require 'rails_helper'

RSpec.describe '/users', type: :request do
  describe 'GET /index' do
    before do
      create :user
      get users_url
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let(:user) { create :user }

    before do
      get user_url(user)
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    let(:user) { create :user }

    before do
      get edit_user_url(user)
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) do
      {
        nhs_number: '111222333',
        last_name: 'DOE',
        dob: "#{Date.today.year - 18}-01-14"
      }
    end

    let(:invalid_attributes) do
      valid_attributes.merge(last_name: 'FOO')
    end

    context 'with valid parameters' do
      it 'creates a new User' do
        expect {
          post users_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect {
          post users_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post users_url, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  xdescribe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested user' do
      end

      it 'redirects to the user' do
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:user) { create :user }

    it 'destroys the requested user' do
      expect {
        delete user_url(user)
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      delete user_url(user)
      expect(response).to redirect_to(users_url)
    end
  end
end
