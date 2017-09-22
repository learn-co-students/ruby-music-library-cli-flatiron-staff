# class MusicImporter
#
#   attr_accessor :path
#
#   def initialize(path)
require 'pry'

class MusicImporter

  attr_accessor :path

    def initialize(path)
      @path = path
      # @files = Dir["#{path}/*.mp3"].each {|file| file.slice!("#{path}/")}
    end

    def files
      files = Dir["#{path}/*.mp3"].each {|file| file.slice!("#{path}/")}
    end

    def import
      files.each {|f| Song.create_from_filename(f)}
    end

end

#     @path = path
#   end
#
#   def files
#     # songs = Dir["#{@path}/"]
#     # songs.collect {|file| file.split("/")[4]}
#     @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
#   end
#
#   def import
#     files.each {|file| Song.create_from_filename(file)}
#   end
#
# end
