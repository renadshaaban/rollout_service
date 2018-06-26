require 'bundler'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'
require 'newrelic_rpm'
Bundler.require

require_rel 'syslib'
Globals.setup

require_rel 'lib'
require_rel 'models'
require_rel 'api'
require_rel 'rollout_service'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete, :patch, :options]
  end
end

use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter
#use NewRelic::Rack::AgentHooks
run ->(_) { [200, {'Content-Type' => 'text/html'}, ['OK']] }
HTTParty::Basement.default_options.update(verify: false) if $env == 'development'

run RolloutService::API