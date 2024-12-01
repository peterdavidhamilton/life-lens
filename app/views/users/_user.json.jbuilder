json.extract! user, :id, :nhs_number, :last_name, :dob, :created_at, :updated_at
json.url user_url(user, format: :json)
