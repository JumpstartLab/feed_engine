root = "/home/deploy/apps/feed_engine/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.feed_engine.sock"
worker_processes 2
timeout 30