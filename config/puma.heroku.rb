# https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#config
# https://devcenter.heroku.com/ja/articles/deploying-rails-applications-with-the-puma-web-server#recommended-default-puma-process-and-thread-configuration
# https://blog.cloud-acct.com/posts/u-docker-rails-herokuyml/
workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup if defined?(DefaultRackup)
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

# https://github.com/seuros/capistrano-example-app/blob/main/config/puma/production.rb
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# https://patorash.hatenablog.com/entry/2019/07/26/095409
# https://github.com/zombocom/puma_worker_killer#configure
before_fork do
  PumaWorkerKiller.config do |config|
    config.ram           = Integer(ENV.fetch('MEMORY_AVAILABLE', 1024)) # 単位はMB。デフォルトは512MB
    config.frequency     = 10    # 単位は秒
    config.percent_usage = 0.90 # ramを90%以上を使用したらワーカー再起動
    config.rolling_restart_frequency = 6 * 3600 # 6時間
    config.reaper_status_logs = true # setting this to false will not log lines like:
    # PumaWorkerKiller: Consuming 54.34765625 mb with master and 2 workers.

    config.pre_term = -> (worker) { puts "Worker #{worker.inspect} being killed" }
    config.rolling_pre_term = -> (worker) { puts "Worker #{worker.inspect} being killed by rolling restart" }
  end
  PumaWorkerKiller.start
end
