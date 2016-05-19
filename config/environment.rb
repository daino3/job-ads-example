# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup

require 'bundler'
Bundler.require

Bundler.setup :default
$: << File.expand_path('../../', __FILE__)

# Require gems we care about
require 'rubygems'
require 'pry'

require 'uri'
require 'mysql2'
require 'active_record'
require 'logger'
# Framework
require 'sinatra'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/support'
require 'sinatra/partial'
require "sinatra/activerecord"
# Elasticsearch
require "elasticsearch"
require 'elasticsearch/model'
# Active Support
require 'active_support'
require 'active_support/core_ext'
# view rendering
require 'slim'
require 'yaml'
# Assets
require 'sass'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

require_relative 'application'
