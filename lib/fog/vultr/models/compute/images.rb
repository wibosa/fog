require 'fog/core/collection'
require 'fog/vultr/models/compute/image'

module Fog
  module Compute
    class Vultr
      class Images < Fog::Collection
        model Fog::Compute::Vultr::Image

        def all
          load service.list_images.body['images']
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
