require 'rails_helper'

RSpec.describe 'Editing answers', type: :system do
  before do
    create :question, :q1
    create :question, :q2
    create :question, :q3
  end

  context 'with different responses' do
    it 'updates score' do
      visit '/'
      click_on 'Get started'
      fill_in 'NHS number', with: '333444555'
      fill_in 'Last name', with: 'CARTER'
      fill_in 'D.O.B.', with: '20-05-1978'
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
      expect(page).to have_text 'Score: 7'

      page.go_back
      choose 'Yes'
      click_button 'Save'

      expect(page).to have_text 'Score: 5'
    end
  end
end
