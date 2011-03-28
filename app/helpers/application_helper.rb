module ApplicationHelper
  
  def app_time_zone_select(options = {})
    select_options = time_zone_options_for_select(current_time_zone_name, same_offset_time_zones)
    select_tag :time_zone, select_options, options
  end

  def current_time_zone_name
    (current_tz = current_time_zone) ? current_tz.name : nil
  end

  def same_offset_time_zones
    return nil unless (current_tz = current_time_zone)
    ActiveSupport::TimeZone.all.select { |tz| tz.utc_offset == current_tz.utc_offset }
  end

end
