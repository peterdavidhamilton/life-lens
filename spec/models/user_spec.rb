require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  describe '#age' do
    specify { expect(user.age).to be 18 }
  end

  describe '#eligible?' do
    context 'when above minimum age' do
      specify { expect(user).to be_eligible }
    end

    context 'when under minimum age' do
      subject(:user) { build(:user, dob: Time.zone.now) }
      specify { expect(user).to_not be_eligible }
    end
  end

  describe 'validation' do
    context 'when details are correct' do
      it do
        expect { user }.to change(User, :count).by(1)
        expect(user).to be_valid
      end
    end

    context 'when required fields are missing' do
      subject(:user) { create(:user, nhs_number: nil) }

      it do
        expect { user }.to raise_error(
          ActiveRecord::RecordInvalid, "Validation failed: NHS number can't be blank")
      end
    end

    context 'when no record exists' do
      subject(:user) { create(:user, :not_found) }

      it do
        expect { user }.to raise_error(
          ActiveRecord::RecordInvalid, 'Validation failed: Your details could not be found')
      end
    end

    context 'when details do not match' do
      subject(:user) { create(:user, :miss_match) }

      it do
        expect { user }.to raise_error(
          ActiveRecord::RecordInvalid, 'Validation failed: Your details could not be found')
      end
    end

    context 'when user is ineligible' do
      subject(:user) { create(:user, :ineligible) }

      it do
        expect { user }.to raise_error(
          ActiveRecord::RecordInvalid, 'Validation failed: You are not eligible for this service')
      end
    end
  end
end
