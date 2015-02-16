module Fog
  module Compute
    class Vultr
      class Real
        def list_regions(options = {})
          request(
            :expects  => [200],
            :method   => 'GET',
            :path     => 'regions'
          )
        end
      end

      class Mock
        def list_regions
          response = Excon::Response.new
          response.status = 200
          response.body = {
            "status" => "OK",
            "regions"  => [
                { "id" => 1, "name" => "New York / New Jersey " },
                { "id" => 2, "name" => "Chicago, Illinois " },
                { "id" => 3, "name" => "Dallas, Texas " },
                { "id" => 4, "name" => "Seattle, Washington " },
                { "id" => 5, "name" => "Los Angeles, California " },
                { "id" => 6, "name" => "Atlanta, Georgia " },
                { "id" => 7, "name" => "(EU) Amsterdam, NL " },
                { "id" => 8, "name" => "(EU) London, UK " },
                { "id" => 9, "name" => "(EU) Frankfurt, DE " },
                { "id" => 12, "name" => "Silicon Valley, California " },
                { "id" => 19, "name" => "(AU) Sydney, Australia " },
                { "id" => 24, "name" => "(EU) Paris, France " },
                { "id" => 25, "name" => "(Asia) Tokyo, Japan " },
                { "id" => 39, "name" => "Miami, Florida " }
            ]
          }
          response
        end
      end
    end
  end
end
