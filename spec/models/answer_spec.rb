require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:value) { true }

  let(:answer) do
    create(:answer, user: user, question: question, value: value)
  end

  describe '#score' do
    describe '16-21' do
      specify do
        expect(answer.score).to eq 1
      end
    end

    describe '22-40' do
      let(:user) do
        create :user, nhs_number: '222333444', last_name: 'smith', dob: '1999-03-02'
      end

      specify do
        expect(answer.score).to eq 2
      end
    end

    describe '41-65' do
      let(:user) do
        create :user, nhs_number: '333444555', last_name: 'carter', dob: '1978-05-20'
      end

      specify do
        expect(answer.score).to eq 3
      end
    end

    describe '64+' do
      let(:user) do
        create :user, nhs_number: '444555666', last_name: 'bond', dob: '1954-07-18'
      end

      specify do
        expect(answer.score).to eq 3
      end
    end
  end

  describe '#score?' do
    describe 'Q1 (points for yes)' do
      context 'when answering yes' do
        specify { expect(answer.score?).to be true }
      end

      context 'when answering no' do
        let(:value) { false }

        specify { expect(answer.score?).to be false }
      end
    end

    describe 'Q3 (points for no)' do
      let(:question) do
        create(:question, name: 'Q3. Do you exercise more than 1 hour per week?')
      end

      context 'when answering yes' do
        specify { expect(answer.score?).to be false }
      end

      context 'when answering no' do
        let(:value) { false }

        specify {  expect(answer.score?).to be true }
      end
    end
  end
end
