require 'rails_helper'

RSpec.describe 'Scoring threshold', type: :system do
  before do
    create :question, :q1
    create :question, :q2
    create :question, :q3
  end

  describe 'when below' do
    it 'rewards the healthy lifestyle' do
      visit '/'
      click_on 'Get started'
      fill_in 'NHS number', with: '222333444'
      fill_in 'Last name', with: 'SMITH'
      fill_in 'D.O.B.', with: '02-03-1999'
      click_on 'Search'

      expect(page).to have_text 'Q1.'
      choose 'No'
      click_button 'Save'

      expect(page).to have_text 'Q2.'
      choose 'No'
      click_button 'Save'

      expect(page).to have_text 'Q3.'
      choose 'No'
      click_button 'Save'

      expect(page).to have_text "we don't need to see you at this time"
      expect(page).to have_text 'Score: 3'
    end
  end

  context 'when above' do
    it 'suggests making lifestyle changes' do
      visit '/'
      click_on 'Get started'
      fill_in 'NHS number', with: '111222333'
      fill_in 'Last name', with: 'DOE'
      fill_in 'D.O.B.', with: '14-01-2006'
      click_on 'Search'

      expect(page).to have_text 'Q1.'
      choose 'Yes'
      click_button 'Save'

      expect(page).to have_text 'Q2.'
      choose 'Yes'
      click_button 'Save'

      expect(page).to have_text 'Q3.'
      choose 'No'
      click_button 'Save'

      expect(page).to have_text 'there are some simple things you could do to improve you quality of life'
      expect(page).to have_text 'Score: 4'
    end
  end
end
