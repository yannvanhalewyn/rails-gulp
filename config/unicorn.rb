# config/unicorn.rb

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"

worker_processes 2
preload_app true
timeout 30

# setup socket location
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# set master PID
pid "#{shared_dir}/pids/unicorn.pid"
