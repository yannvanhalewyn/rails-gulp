# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server '77.77.77.7', user: 'deploy', roles: %w{app db web}

namespace :upstart do
  desc "Copy unicorn upstart script to /etc/init"
  task :copy_config do
    on roles(:app) do |host|
      unicorn = File.join(current_path, "config", "unicorn_railsapp.conf")
      sudo :cp, unicorn, "/etc/init/"
    end
  end

  task :restart do
    on roles(:app) do |host|
      sudo 'restart unicorn_railsapp'
    end
  end
end

task :upstart do
  invoke 'upstart:copy_config'
  invoke 'upstart:restart'
end

namespace :npm do
  task :install do
    on roles(:app) do |host|
      execute "cd #{current_path} && npm install"
    end
  end
end

after 'deploy:finished', 'npm:install'
after 'deploy:finished', 'upstart'

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
