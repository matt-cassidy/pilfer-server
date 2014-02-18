class CreateFileLineProfiles < ActiveRecord::Migration
  def change
    create_table :file_line_profiles do |t|
      t.references :file_profile
      t.integer :line_number
      t.integer :wall_time
      t.integer :cpu_time
      t.integer :calls

      t.timestamps
    end
  end
end
