# WIP: explicit reversible migration add a postgres function
class RecreateUsers < ActiveRecord::Migration[8.0]
  def down
    drop_table :users do |t|
      t.string :nhs_number, null: false
      t.string :last_name, null: false
      t.date :dob
      t.index %i[nhs_number last_name]
      t.timestamps
    end

    disable_extension 'uuid-ossp' if extension_enabled?('uuid-ossp')

    create_table :users do |t|
      t.string :nhs_number
      t.string :last_name
      t.date :dob
      t.timestamps
    end
  end

  def up
    drop_table :users do |t|
      t.string :nhs_number
      t.string :last_name
      t.date :dob
      t.timestamps
    end

    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')

    create_table :users, id: :uuid do |t|
      t.string :nhs_number, null: false
      t.string :last_name, null: false
      t.date :dob
      t.index %i[nhs_number last_name]
      t.timestamps
    end
  end
end
