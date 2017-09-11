require 'csv'
require 'rubygems'
require 'zip'
require 'net/http'
class Downloadfile
 def downloadfile
     Net::HTTP.start("s3.amazonaws.com") do |http|
      content = http.get("http://s3.amazonaws.com/alexa-static/top-1m.csv.zip")
      File.open("myfile", "w") do |file|
        file.write(content.body)
      end
     end
     puts"downloaded"
    
 end
end
@download=Downloadfile.new
@download.downloadfile 

class Unzip
  def unzip_file (file, destination)
    Zip::File.open(file) do |zip_file|
      zip_file.each do |f|
        f_path = File.join(destination, f.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        f.extract(f_path) unless File.exist?(f_path)
        @a=f
      end
    end
  end

end 
@unzip=Unzip.new
@unzip.unzip_file("myfile", "/home/riya/new")