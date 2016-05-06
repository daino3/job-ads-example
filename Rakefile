require 'rake'
require_relative './config/environment'
require 'active_support/core_ext'
require "sinatra/activerecord/rake"

desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r./config/environment"
end
