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
                { "id" => 1, "name" => "Chicago, Illinois " },
                { "id" => 2, "name" => "New York / New Jersey " },
                { "id" => 3, "name" => "Dallas, Texas " },
                { "id" => 4, "name" => "Atlanta, Georgia " },
                { "id" => 5, "name" => "Miami, Florida " },
                { "id" => 6, "name" => "Silicon Valley, California " },
                { "id" => 7, "name" => "Los Angeles, California " },
                { "id" => 8, "name" => "Seattle, Washington " },
                { "id" => 9, "name" => "(AU) Sydney, Australia " },
                { "id" => 10, "name" => "(Asia) Tokyo, Japan " },
                { "id" => 11, "name" => "(EU) Amsterdam, NL " },
                { "id" => 12, "name" => "(EU) Frankfurt, DE " },
                { "id" => 13, "name" => "(EU) London, UK " },
                { "id" => 14, "name" => "(EU) Paris, France " }
            ]
          }
          response
        end
      end
    end
  end
end
