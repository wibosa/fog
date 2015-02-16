require 'fog/vultr/core'

module Fog
  module Compute
    class Vultr < Fog::Service
      requires     :vultr_api_key
      requires     :vultr_client_id

      recognizes   :vultr_api_url

      model_path   'fog/vultr/models/compute'
      model        :server
      collection   :servers
      model        :flavor
      collection   :flavors
      model        :image
      collection   :images
      model        :region
      collection   :regions
      model        :ssh_key
      collection   :ssh_keys

      request_path 'fog/vultr/requests/compute'
      request      :list_servers
      request      :list_images
      request      :list_regions
      request      :list_flavors
      request      :get_server_details
      request      :create_server
      request      :destroy_server
      request      :reboot_server
      request      :power_cycle_server
      request      :power_off_server
      request      :power_on_server
      request      :shutdown_server
      request      :list_ssh_keys
      request      :create_ssh_key
      request      :get_ssh_key
      request      :destroy_ssh_key

      # request :vultr_resize

      class Mock
        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {
              :servers => [],
              :ssh_keys => []
            }
          end
        end

        def self.reset
          @data = nil
        end

        def initialize(options={})
          @vultr_api_key = options[:vultr_api_key]
        end

        def data
          self.class.data[@vultr_api_key]
        end

        def reset_data
          self.class.data.delete(@vultr_api_key)
        end
      end

      class Real
        def initialize(options={})
          @vultr_api_key   = options[:vultr_api_key]
          @vultr_client_id = options[:vultr_client_id]
          @vultr_api_url   = options[:vultr_api_url] || \
                                            "https://api.vultr.com"
          @connection             = Fog::XML::Connection.new(@vultr_api_url)
        end

        def reload
          @connection.reset
        end

        def request(params)
          params[:query] ||= {}
          params[:query].merge!(:api_key   => @vultr_api_key)
          params[:query].merge!(:client_id => @vultr_client_id)

          response = retry_event_lock { parse @connection.request(params) }

          unless response.body.empty?
            if response.body['status'] != 'OK'
              case response.body['error_message']
              when /No Droplets Found/
                raise Fog::Errors::NotFound.new
              else
                raise Fog::Errors::Error.new response.body.to_s
              end
            end
          end
          response
        end

        private

        def parse(response)
          return response if response.body.empty?
          response.body = Fog::JSON.decode(response.body)
          response
        end

        def retry_event_lock
          count   = 0
          response = nil
          while count < 5
            response = yield

            if response.body && response.body['error_message'] =~ /There is already a pending event for the droplet/
              count += 1
              sleep count ** 3
            else
              break
            end
          end

          response
        end
      end
    end
  end
end
