require 'fog/core/collection'
require 'fog/vultr/models/compute/flavor'

module Fog
  module Compute
    class Vultr
      class Flavors < Fog::Collection
        model Fog::Compute::Vultr::Flavor

        def all
          load service.list_flavors.body['sizes']
        end

        def get(id)
          all.find { |f| f.id == id }
        rescue Fog::Errors::NotFound
          nil
        end
      end
    end
  end
end
