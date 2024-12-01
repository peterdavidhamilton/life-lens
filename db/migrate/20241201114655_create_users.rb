class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :nhs_number
      t.string :last_name
      t.date :dob

      t.timestamps
    end
  end
end
