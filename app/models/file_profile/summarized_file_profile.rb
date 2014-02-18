class FileProfile::SummarizedFileProfile
  attr_reader :wall, :cpu, :idle, :calls

  def initialize(line_mappings)
    @wall, @cpu, @idle, @calls = [], [], [], []
    line_mappings.each(&method(:add))
  end

  private
  def add(profile)
    @wall  << profile.try(:wall_time)
    @cpu   << profile.try(:cpu_time)
    @idle  << profile.try(:idle_time)
    @calls << profile.try(:calls)
  end


end