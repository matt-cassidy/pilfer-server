class Profile < ActiveRecord::Base
  serialize :payload, JSON
  serialize :file_sources, JSON

  belongs_to :app

  has_many :file_profiles, :dependent => :destroy

  scope :latest, -> { limit(50).order('id DESC') }

  default_scope includes(:file_profiles => :file_line_profiles)

  after_create :to_relational_models!

  def total_time
    file_profiles.sum('total')
  end

  def cpu_time
    file_profiles.sum('total_cpu')
  end

  def idle_time
    [ 0, total_time - cpu_time ].max
  end

  def self.to_relational_models!(profile)
    ActiveRecord::Base.transaction(:requires_new => true) do
      profile.file_sources.each do |file_name, contents|
        file_source = profile.app.file_sources.find_or_initialize_by_app_id_and_file_name_and_contents!(profile.app_id, file_name, contents)

        file_profile_hsh = profile.payload.fetch('files', Hash.new)[file_name]
        next if file_profile_hsh.nil?
        file_profile = profile.file_profiles.create! :total => file_profile_hsh['total'],
                                                     :child => file_profile_hsh['child'],
                                                     :exclusive => file_profile_hsh['exclusive'],
                                                     :total_cpu => file_profile_hsh['total_cpu'],
                                                     :child_cpu => file_profile_hsh['child_cpu'],
                                                     :exclusive_cpu => file_profile_hsh['exclusive_cpu'],
                                                     :file_source_id => file_source.id

        file_profile_hsh['lines'].each do |line_number, line_profile|
          file_profile.file_line_profiles.create! :line_number => line_number,
                                                  :wall_time => line_profile['wall_time'],
                                                  :cpu_time => line_profile['cpu_profile'],
                                                  :calls => line_profile['calls']

        end
      end
    end
  end

  protected

  def to_relational_models!
    self.class.to_relational_models!(self)
  end
end
