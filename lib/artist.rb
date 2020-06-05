require 'pry'

class Artist
    extend Concerns::Findable
    attr_accessor :name, :genres
  
    @@all = []
  
    def initialize(name)
      @name = name
      @songs = []
    end
  
    def self.all
      @@all
    end
  
    def self.destroy_all
      @@all.clear
    end
  
    def save
      @@all << self
    end
  
    def self.create(name)
      artist = Artist.new(name)
      artist.save
      artist
    end

    def songs
        @songs
    end 

    def add_song(song)
        if @songs.include?(song) 
          return 
        elsif song.artist == nil
          @songs << song
          song.artist = self
        else 
          @songs << song
        end 
    end 

    def genres 
      a = self.songs.map do |song| 
          song.genre
      end 
      a.uniq
    end 

end 