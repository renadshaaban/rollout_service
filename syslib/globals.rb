require 'erb'
module Globals
  extend self

  def environment
    $env = ENV['RACK_ENV'] || 'development'
    puts $env
  end

  def redis

    config =  YAML.load(ERB.new(File.read('./config/redis.yml')).result)[$env]
    puts YAML.load(ERB.new(File.read('./config/redis.yml')).result)
    puts config
    $redis = Redis.new(config)
    puts $redis
  end

  def rollout
    $rollout = Rollout.new($redis, use_sets: true)
  end

  def authentication
    config =  YAML.load(File.read('./config/authentication.yml'))[$env]
    $google_oauth_allowed_domain = config[:google_oauth_allowed_domain]
  end

  def setup
    environment
    redis
    rollout
    authentication
  end
end


