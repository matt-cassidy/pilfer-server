class CreateFileSources < ActiveRecord::Migration
  def change
    create_table :file_sources do |t|
      t.references :app

      t.string :file_name
      t.text :contents
      t.text :hashed_contents

      t.timestamps
    end

    add_index(:file_sources, [:app_id, :hashed_contents], unique: true)
  end
end
