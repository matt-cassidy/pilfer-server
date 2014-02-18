class FileSource < ActiveRecord::Base
  belongs_to :app

  has_many :file_profiles, :dependent => :destroy

  before_validation :set_hashed_contents!

  validates_presence_of :file_name, :contents, :hashed_contents

  validates! :hashed_contents, uniqueness: { :scope => :app_id }

  def self.find_or_initialize_by_app_id_and_file_name_and_contents!(app_id, file_name, contents)
     model = where(:app_id => app_id).where(:hashed_contents => hash_key_for(file_name, contents)).first

     return model if model.present?

     create!(:app_id => app_id, :file_name => file_name, :contents => contents)
  end

  def self.hash_key_for(file_name,contents)
    Digest::MD5.hexdigest("#{file_name}:#{contents}").encode('UTF-8')
  end

  def each_line
    contents.split("\n").each_with_index
  end

  protected

  def set_hashed_contents!
    self.hashed_contents = self.class.hash_key_for(file_name, contents)
  end

end
