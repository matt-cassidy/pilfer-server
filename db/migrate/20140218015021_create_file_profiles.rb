class CreateFileProfiles < ActiveRecord::Migration
  def change
    create_table :file_profiles do |t|
      t.references :file_source
      t.references :profile

      t.timestamp :timestamp
      t.integer :total
      t.integer :total_cpu
      t.integer :child
      t.integer :child_cpu
      t.integer :exclusive
      t.integer :exclusive_cpu

      t.timestamps
    end
  end
end
