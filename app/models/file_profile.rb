class FileProfile < ActiveRecord::Base
  belongs_to :profile
  belongs_to :file_source
  has_many :file_line_profiles, :dependent => :destroy
end
