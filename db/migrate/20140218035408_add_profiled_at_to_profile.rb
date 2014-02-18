class AddProfiledAtToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :profiled_at, :timestamp
  end
end
