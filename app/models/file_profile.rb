class FileProfile < ActiveRecord::Base
  belongs_to :profile
  belongs_to :file_source
  has_many :file_line_profiles, :dependent => :destroy

  delegate :file_name, :to => :file_source

  def idle_time
    calculate_idle total, total_cpu
  end

  def exclusive_idle_time
    calculate_idle exclusive, exclusive_cpu
  end

  scope :by_file_name, ->(file_name) do
    joins(:file_source).where(:file_sources => {:file_name => file_name })
  end

  scope :sort_by_summary_and_value, ->(summary, sort) do
    if summary == 'exclusive'
      if sort == 'idle'
        sort_by(&:exclusive_idle_time)
      elsif sort == 'cpu'
        order 'exclusive_cpu desc'
      else
        order 'exclusive desc'
      end
    else
      if sort == 'idle'
        sort_by(&:idle_time)
      elsif sort == 'cpu'
        order 'total_cpu desc'
      else
        order 'total desc'
      end
    end
  end


  private

  def calculate_idle(total_time,cpu_time)
    [ 0, total_time - cpu_time ].max
  end
end
