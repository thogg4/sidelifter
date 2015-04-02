require 'droplet_kit'

module Sidelifter
  class DigitalOcean < Provider

    desc 'servers', 'List all created servers'
    def servers
      client.droplets.all
    end

    desc 'create_server', 'Spin up a new server'
    def create_server
      c = client

      user_data_dir = ENV['USER_DATA']

      chosen_name = ask('Server Name:')

      chosen_image = choose_image(c.images.all) { |image| "#{image.distribution} #{image.name}" }
      chosen_region = choose_region(c.regions.all) { |region| region.name }
      chosen_size = choose_size(chosen_region.sizes) { |size| size }

      chosen_user_data = choose do |menu|
        menu.prompt = 'User Data file to apply to Server:'
        menu.layout = menu_layout
        files = user_data_files
        files.each do |file|
          menu.choice(file[:name]) { file }
        end
      end

      say 'Creating Server...'
      droplet = DropletKit::Droplet.new(name: chosen_name, region: chosen_region.slug, image: chosen_image.slug, size: chosen_size, user_data: chosen_user_data[:contents])
      begin
        c.droplets.create(droplet)
        say 'Server Created'
      rescue => e
        say "Server Not Created: #{e}"
      end
    end

    private

    def client
      access_token = ENV['DIGITAL_OCEAN_ACCESS_TOKEN']
      raise 'ENV variable not set: DIGITAL_OCEAN_ACCESS_TOKEN' unless access_token

      DropletKit::Client.new(access_token: access_token)
    end

    def deploy_server
    end

  end
end
