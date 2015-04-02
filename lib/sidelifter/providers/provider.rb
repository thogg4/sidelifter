class Provider < Thor
  include Sidelifter::Output

  no_commands do

    def choose_image(images, &block)
      chosen_image = choose do |menu|
        menu.prompt = 'Server Image:'
        menu.layout = menu_layout
        images.each do |image|
          menu.choice(block.call(image)) { image }
        end
      end
    end

    def choose_region(regions, &block)
      choose do |menu|
        menu.prompt = 'Server Region:'
        menu.layout = menu_layout
        regions.each do |region|
          menu.choice(block.call(region)) { region }
        end
      end
    end

    def choose_size(sizes, &block)
      choose do |menu|
        menu.prompt = 'Server Size:'
        menu.layout = menu_layout
        sizes.each do |size|
          menu.choice(block.call(size)) { size }
        end
      end
    end

    def menu_layout
      "\n" +
      "\n" +
      "<%= list(@menu, #{@flow.inspect}, #{@list_option.inspect}) %>" +
      "\n" +
      "<%= @prompt %>"
    end

    def user_data_file(file_name)
      
    end

    def user_data_files
      user_data_dir = ENV['USER_DATA']
      raise Sidelifter::Error::NoUserDataVariable unless user_data_dir
      file_names = Dir.entries(user_data_dir).reject { |e| Dir.exist?(e) }
      file_names.map { |name| { name: name, path: File.expand_path(name, user_data_dir), contents: File.read(File.expand_path(name, user_data_dir)) } }
    end
  end

  def method_missing(method_name, *args, &block)
    puts "#{method_name} is not a supported command"
  end

end
