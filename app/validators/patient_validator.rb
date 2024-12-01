# Validate user records against external restricted data source using NHS Number.
#
# @author P. Hamilton
# @see https://al-tech-test-apim.azure-api.net/tech-test/t2
#
class PatientValidator < ActiveModel::Validator
  # Patient surname and date of birth must be correct.
  #
  # @param record [User]
  # @return [nil]
  def validate(record)
    response = fetch_record(record.nhs_number)
    data = JSON.parse(response.body)

    case response.code
    when 200
      if invalid_dob?(record, data) || invalid_last_name?(record, data)
        record.errors.add :base, error_message
      end
    when 404
      record.errors.add :base, error_message
    else
      Rails.logger.warn data['message']
    end
  end

  private

  # @param nhs_number [String]
  # @return [HTTP::Response]
  def fetch_record(nhs_number)
    HTTP.get("#{Rails.application.config.api_url}/#{nhs_number}",
      headers: { 'Ocp-Apim-Subscription-Key' => Rails.application.config.api_token
    })
  end

  # @return [String]
  def error_message
    I18n.t(:not_found, scope: self.class.name.underscore)
  end

  # @param record [User]
  # @param data [Hash]
  # @return [Boolean] Check DOB matches
  def invalid_dob?(record, data)
    record.dob != Date.parse(data['born'])
  end

  # @param record [User]
  # @param data [Hash]
  # @return [Boolean] Check Surname matches
  def invalid_last_name?(record, data)
    record.last_name.downcase != data['name'].split(', ').first.downcase
  end
end
