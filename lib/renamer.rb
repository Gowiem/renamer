require "renamer/version"

RENAME_REGEX=/(.*)(S0.E..)(.*)\.(.*)/i

module Renamer
  
  def self.rename(input_dir, output_dir)
    files = `ls #{input_dir}`.split("\n")

    files.each do |file|
      match_data = RENAME_REGEX.match(file)

      if match_data.nil?
        new_name = prompt "No match found for file: #{file}. Please enter new name: "
      else
        new_name = "#{match_data[2]}.#{match_data[4]}"
      end

      confirmation = prompt "Confirm renaming file #{file} to #{new_name} - [y/n]: "

      if confirmation == "y" && !new_name.nil?
        if output_dir.nil?
          `mv #{input_dir}#{file} #{input_dir}#{new_name}`
        else
          `mv #{input_dir}#{file} #{output_dir}#{file}`
        end
      end

      puts '----------------'
    end
  end

  private

  def self.prompt(*args)
    print(*args)
    users_value = gets
    users_value.strip
  end

end
