require 'rubygems'

require 'open-uri'
require 'zip'

def download(url, path)
  puts('downloading ' + path)
  File.open(path, "w") do |f|
    IO.copy_stream(open(url), f)
  end
end

def unzip_file (file, destination)
  puts('unzipping ' + file + ' to ' + destination)
  Zip::File.open(file) do |zip_file|
    # Handle entries one by one
    zip_file.each do |entry|
      f_path = File.join(destination, entry.name)
      FileUtils.mkdir_p(File.dirname(f_path))
      zip_file.extract(entry, f_path) unless File.exist?(f_path)
    end
  end
end

