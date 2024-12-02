class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :value, inclusion: [ true, false ], exclusion: [ nil ]

  # WIP: Age ranges require attention, as a user aged 64/65, appears in more than one
  # WIP: Part 3 - age ranges could be defined in a dedicated model and referenced by the Answer
  AGE_RANGES = [ (16..21), (22..40), (41..65), (64..) ]

  # WIP: Part 3 - point values for individual questions could be moved to the database and handled by content authors
  POINTS = [
    [ 1, 2, 3, 3 ],
    [ 2, 2, 2, 3 ],
    [ 1, 3, 2, 1 ]
  ]

  # AGE	16-21	  22-40	  41-65	  64+
  # Q1	1	      2	      3	      3
  # Q2	2	      2	      2	      3
  # Q3	1	      3	      2	      1
  #
  # @todo Fix scoring system, the maximum score should not exceed 7,
  # @return [Integer]
  def score
    return 0 unless score?

    AGE_RANGES.map.with_index { |range, column|
      row = question.number - 1
      POINTS[row][column] if range.include?(user.age)
    }.compact.sum
    # WIP: short term fix, replace "sum" with "pop" to use the penultimate range only. "sum" is used to illustrate the issue in a system spec
  end

  # WIP: Part 3 - changes to scoring logic could be controlled by a toggle on the question record
  # @return [Boolean] Points awarded for answering YES, except Q3
  def score?
    return true if question.last? && !value
    return true if !question.last? && value

    false
  end
end
