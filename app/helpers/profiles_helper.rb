module ProfilesHelper
  def profile_time(microseconds)
    return unless microseconds
    microseconds = 0 if microseconds < 0
    number_to_human(microseconds / 1000.0,
                    format:      '%n%u',
                    precision:   2,
                    significant: false,
                    strip_insignificant_zeros: false,
                    units:       { unit: 'ms', thousand: 's' })
  end

  def profile_time_default(microseconds)
    number_to_human(microseconds / 1000.0,
                    precision: 2,
                    significant: false,
                    units: { unit: 'ms', thousand: 's' })
  end

  def profile_class(profile)
    time = profile.total_time / 1000.0
    if time > @minimum * 10
      'error'
    elsif time > @minimum
      'warning'
    end
  end

  def was_profiled_at(profile)
    date_time =
        if profile.profiled_at.present?
          profile.profiled_at
        else
          profile.created_at
        end
    time_ago_in_words(date_time)
  end

  def file_profile_class(file_profile, index = :none)
    total = if index == :none
              file_profile.total
            else
              profile_line_wall_time(file_profile, index) || 0
            end
    total = total / 1000.0
    if total > @minimum * 100
      'error'
    elsif total > @minimum
      'warning'
    end
  end

  def line_called?(line_profile)
    line_profile && line_profile.calls > 0
  end

  def profile_line_wall_time(file_profile, index)
    profile_line(file_profile, index, &:wall_time)
  end

  def profile_line_cpu_time(file_profile, index)
    profile_line(file_profile, index, &:cpu_time)
  end

  def profile_line_idle_time(file_profile, index)
    profile_line(file_profile, index, &:idle_time)
  end

  def profile_line_calls(file_profile, index)
    profile_line(file_profile, index, &:calls)
  end

  def profile_line(file_profile,index)
    line_profile = file_profile.file_line_profiles.where(:line_number => index).first
    return unless line_called?(line_profile)
    yield line_profile
  end
end
