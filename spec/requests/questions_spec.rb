require 'rails_helper'

RSpec.describe '/questions', type: :request do
  describe 'GET /show' do
    let(:q1) { create :question, :q1 }

    context 'with active session' do
      before do
        create :question, :q2
        session = { user_id: create(:user).id }
        allow_any_instance_of(QuestionsController).to receive(:session).and_return(session)
        get question_url(q1)
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end
    end

    context 'without active session' do
      before { get question_url(q1) }

      it 'redirects' do
        expect(response).to redirect_to new_user_path
      end
    end
  end
end
