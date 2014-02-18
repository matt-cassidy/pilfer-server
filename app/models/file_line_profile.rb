class FileLineProfile < ActiveRecord::Base
  belongs_to :file_profile

  def idle_time
    [ 0, (wall_time || 0) - (cpu_time || 0) ].max
  end
end
