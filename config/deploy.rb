# config valid for current version and patch releases of Capistrano
lock "~> 3.18.0"

set :application, "calmmigration"
set :repo_url, "git@github.com:kevinluo201/calmmigration.git"
set :passenger_restart_with_touch, true

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
ask :branch, :main

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/var/www/calmmigration"
set :tmp_dir, "/var/www/calmmigration/shared/tmp"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "public/assets", "log", "tmp/pids", "tmp/sockets", "node_modules"
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :rvm_ruby_version, '3.1.2'

# for Vite
set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v18.20.2'
set :nvm_map_bins, %w{npm rake}
set :assets_prefix, 'vite/.vite'