require 'rails_helper'

RSpec.describe PatientValidator do
  let(:record) { build(:user) }

  describe 'validation' do
    before do
      described_class.new.validate(record)
    end

    context 'with known patient' do
      specify { expect(record).to be_valid }
    end

    context 'with unknown patient' do
      let(:record) { build(:user, :not_found) }

      specify { expect(record).to_not be_valid }
    end
  end

  context 'with broken token' do
    before do
      allow(Rails.application.config).to receive(:api_token).and_return('expired')
    end

    let(:error_message) do
      'Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription.'
    end

    it 'logs access failure' do
      expect(Rails.logger).to receive(:warn).with(error_message)
      described_class.new.validate(record)
    end
  end

  context 'with invalid url' do
    before do
      allow(Rails.application.config).to receive(:api_url).and_return('http://localhost')
    end

    specify do
      expect { described_class.new.validate(record) }.to raise_error HTTP::ConnectionError
    end
  end
end
