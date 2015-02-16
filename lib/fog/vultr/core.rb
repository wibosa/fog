require 'fog/core'
require 'fog/json'

module Fog
  module Vultr
    extend Fog::Provider
    service(:compute, 'Compute')
  end
end
