require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:q1) { create :question, :q1 }
  let!(:q2) { create :question, :q2 }
  let!(:q3) { create :question, :q3 }

  describe '.first' do
    it 'returns Q1.' do
      expect(described_class.first).to eq q1
    end
  end

  describe '#name' do
    specify do
      expect(build(:question)).to be_valid
      expect(build(:question, name: nil)).to_not be_valid
    end
  end

  describe '#number' do
    specify do
      expect(q1.number).to eq 1
    end
  end

  describe '#last?' do
    specify do
      expect(q1).to_not be_last
      expect(q2).to_not be_last
      expect(q3).to be_last
    end
  end

  describe '#next' do
    it 'returns next in sequence' do
      expect(q1.next).to eq q2
    end
  end
end
