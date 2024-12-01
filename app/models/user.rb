class User < ApplicationRecord
  # @return [Integer] users must be 16 or over
  MINIMUM_AGE = 16

  validates :nhs_number, presence: true
  validates :last_name, presence: true
  validates :dob, presence: true

  validates_with PatientValidator, fields: %i[nhs_number last_name dob], if: proc { patient_data? }

  validate :eligible_age

  def eligible_age
    if errors.empty? && !eligible?
      errors.add :base, I18n.t(:under_age, scope: self.class.name.underscore)
    end
  end

  # @return [Boolean] retrieval from external source possible
  def patient_data?
    [ nhs_number, dob, last_name ].all?(&:present?)
  end

  # @return [Boolean] must be 16 or over
  def eligible?
    age >= MINIMUM_AGE
  end

  # @return [Integer]
  def age
    Date.today.year - dob.year
  end
end
