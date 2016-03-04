lock "3.4.0"

set :application, "acid_tango_blog"
set :repo_url, "git@github.com:acidtango/publify.git"
set :bundle_without, [:darwin, :development, :test]
set :deploy_to, "/opt/acid_tango_blog"

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push("config/database.yml config/mail.yml")

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, [])
  .push("log", "tmp/pids", "tmp/cache",
        "tmp/sockets", "vendor/bundle", "public/system")

# set :pty, false

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, "cache:clear"
      # end
    end
  end
end

# lib/capistrano/tasks/agent_forwarding.rake
desc "Check if agent forwarding is working"
task :forwarding do
  on roles(:all) do |h|
    if test("env | grep SSH_AUTH_SOCK")
      info "Agent forwarding is up to #{h}"
    else
      error "Agent forwarding is NOT up to #{h}"
    end
  end
end