require 'rails_helper'

RSpec.describe 'Login', type: :system do
  before do
    create :question, :q1
    create :question, :q2
    create :question, :q3
  end

  context 'when eligible' do
    it 'succeeds' do
      visit '/'

      click_on 'Get started'

      fill_in 'NHS number', with: '111222333'
      fill_in 'Last name', with: 'DOE'
      fill_in 'D.O.B.', with: "14-01-#{Date.today.year - 18}"

      click_on 'Search'

      expect(page).to have_current_path(question_path(Question.first))
      expect(page).to have_text 'Welcome'
    end
  end

  context 'when ineligible' do
    it 'succeeds' do
      visit '/'

      click_on 'Get started'

      fill_in 'NHS number', with: '555666777'
      fill_in 'Last name', with: 'MAY'
      fill_in 'D.O.B.', with: "14-11-#{Date.today.year - 14}"

      click_on 'Search'

      expect(page).to have_current_path(new_user_path)
      expect(page).to have_text 'You are not eligible for this service'
    end
  end

  context 'when not found' do
    it 'fails' do
      visit '/'

      click_on 'Get started'

      fill_in 'NHS number', with: '123456789'
      fill_in 'Last name', with: 'Hamilton'
      fill_in 'D.O.B.', with: '02-12-2024'

      click_on 'Search'

      expect(page).to have_current_path(new_user_path)
    end
  end
end
