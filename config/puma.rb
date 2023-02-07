# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# https://qiita.com/NaokiIshimura/items/7cb2390243939a34754f#rails-3
# bind "unix://#{app_root}/tmp/sockets/puma.sock"

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# 出力先を変更
# stdout_redirect "#{app_root}/log/puma.stdout.log", "#{app_root}/log/puma.stderr.log", true
# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# https://patorash.hatenablog.com/entry/2019/07/26/095409
before_fork do
  PumaWorkerKiller.config do |config|
    config.ram           = Integer(ENV.fetch('MEMORY_AVAILABLE', 1024))
    config.frequency     = 10    # 単位は秒
    config.percent_usage = 0.90 # ramを90%以上を使用したらワーカー再起動
    config.rolling_restart_frequency = 6 * 3600 # 6時間
    # PumaWorkerKiller: Consuming 54.34765625 mb with master and 2 workers.
  end
  PumaWorkerKiller.start
end
