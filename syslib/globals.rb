require 'erb'
module Globals
  extend self

  def environment
    $env = ENV['RACK_ENV'] || 'development'
    puts $env
  end

  def redis
    $redis = Redis.new()
  end

  def rollout
    $rollout = Rollout.new($redis, use_sets: true)
  end

  def authentication
    config =  YAML.load(File.read('./config/authentication.yml'))[$env]
    $google_oauth_allowed_domain = config[:google_oauth_allowed_domain]

    puts $google_oauth_allowed_domain
    puts config
    puts $google_oauth_allowed_domain.blank?
  end

  def setup
    environment
    redis
    rollout
    authentication
  end
end


