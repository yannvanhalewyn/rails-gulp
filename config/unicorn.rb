# config/unicorn.rb

app_dir = File.expand_path("../..", __FILE__)
tmp_dir = "#{app_dir}/tmp"

worker_processes 2
preload_app true
timeout 30

# setup socket location
listen "#{tmp_dir}/sockets/unicorn.sock", :backlog => 64

# logging
stderr_path "#{app_dir}/log/unicorn.stderr.log"
stdout_path "#{app_dir}/log/unicorn.stdout.log"

# set master PID
pid "#{tmp_dir}/pids/unicorn.pid"
