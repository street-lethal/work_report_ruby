require 'date'
require 'yaml'
require_relative './jira_parser'

settings =
  if File.exist? '/app_root/config/settings.yml'
    YAML.load_file('/app_root/config/settings.yml')
  else
    YAML.load_file('/app_root/config/settings.sample.yml').tap do |settings|
      settings['holidays'] = []
    end
  end

today = Date.today
first_of_current_month = Date.new(today.year, today.month, 1)
first_of_target_month = first_of_current_month.prev_month(settings['months_ago'].to_i)
last_of_target_month = first_of_target_month.next_month.prev_day

jira = JiraParser.new

File.open('/app_root/data/report_data.txt', 'w+') do |f|
  (first_of_target_month..last_of_target_month).each_with_index do |date, i|
    next if date.saturday? || date.sunday?
    next if settings['holidays'].include? date.day

    base = "data[DailyReport][#{date.strftime('%Y%m%d')}]"
    f.puts "#{base}[target_date]=#{date.strftime('%Y-%m-%d')}&"
    f.puts "#{base}[start_time]=#{settings.dig('daily_report', 'starts_at')}&"
    f.puts "#{base}[end_time]=#{settings.dig('daily_report', 'ends_at')}&"
    f.puts "#{base}[relax_time]=#{settings.dig('daily_report', 'rest_time')}&"
    f.puts "#{base}[work_content]=#{jira.merged_works[i]}&"
    f.puts nil
  end
end
