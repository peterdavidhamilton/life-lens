require 'rails_helper'

RSpec.describe 'Home page', type: :system do
  specify do
    visit '/'
    expect(page).to have_text 'Life Lens'
    expect(page).to have_text 'Get started'
  end
end
