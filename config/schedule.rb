set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 1.day, :at => '5:00 am' do
  rake "load:postings"
end

every 1.day, :at => '5:00 pm' do
  rake "load:postings"
end
