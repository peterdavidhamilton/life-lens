class Question < ApplicationRecord
  validates :name, presence: true

  # @return [Question] Q1.
  def self.first
    all.find { |q| q.number == 1 }
  end

  # WIP: Part 3 - the "Qn." prefix acts like a numeric field which could be extracted
  # @return [Integer]
  def number
    name.match(%r{\bQ(\d+)\.})[1].to_i
  end

  # WIP: Part 3 - extra questions or new scoring will require a refactor here
  # @return [Boolean]
  def last?
    # WIP: self.class.last is not sufficiently robust if the prefix is renumbered and questions aren't persisted in order
    number.eql?(3)
  end

  # @return [Question]
  def next
    self.class.all.find { |q| q.number.eql?(number + 1) }
  end
end
