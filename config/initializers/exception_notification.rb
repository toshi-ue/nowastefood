if Rails.env.production?
  require 'exception_notification/rails'
  ExceptionNotification.configure do |config|
    config.add_notifier :slack,
      webhook_url: ENV['SLACK_WEBHOOK_URL'],
      channel: "##{ENV['SLACK_CHANNEL']}"
  end
end
