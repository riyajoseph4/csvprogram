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
        a="#{@a}"
        i=1
        $ar=[]
        CSV.foreach(a) do |row| 
            $ar << row[1]
            i=i+1
            if (i==1000) 
                break
            end
        end
    end
end 
@unzip=Unzip.new
@unzip.unzip_file("myfile", "/home/riya/new")

class SortContents

    puts "SORTED LIST:::::::::::::::::::"
    def mergesort(list)
        return list if list.size <= 1
        mid   = list.size / 2
        left  = list[0, mid]
        right = list[mid, list.size]
        merge(mergesort(left), mergesort(right))
    end

    def merge(left, right)
        sorted = []
        until left.empty? || right.empty? do
            if left.first <= right.first
                sorted << left.shift
            else
                sorted << right.shift
            end
        end
        @y=sorted.concat(left).concat(right)
    end
    def writeFile
        File.open("temp","w") {|file| file.puts(@y)}
    end
end
@sort=SortContents.new
@sort.mergesort($ar)
@sort.writeFile
