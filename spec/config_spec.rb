require 'rails_helper'

RSpec.describe 'Application configuration' do
  subject(:config) { LifeLens::Application.config }

  it 'sets time zone' do
    expect(config.time_zone).to eq 'Europe/London'
  end

  it 'sets API endpoint' do
    expect(config.api_url).to be_present
  end

  it 'sets AP{I token}' do
    expect(config.api_token).to be_present
  end
end
