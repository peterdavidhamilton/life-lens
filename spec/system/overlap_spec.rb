require 'rails_helper'

# WIP: This test demos the issue. Such a user would still exceed the point threshold however their score would change.
RSpec.describe 'Overlapping user range', type: :system do
  before do
    create :question, :q1
    create :question, :q2
    create :question, :q3
  end

  it 'changes score' do
    visit '/'
    click_on 'Get started'
    fill_in 'NHS number', with: '444555666'
    fill_in 'Last name', with: 'BOND'
    fill_in 'D.O.B.', with: '18-07-1954'
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

    expect(page).to have_text 'Score: 7'

    allow_any_instance_of(User).to receive(:age).and_return(64)

    expect(User.first.score).to eq 14
  end
end
