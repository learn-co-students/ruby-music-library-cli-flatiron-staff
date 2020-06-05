require 'pry'

class Genre
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :songs
    
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
        genre = Genre.new(name)
        genre.save
        genre
    end

    def artists
        a = self.songs.map do |song|
            song.artist
        end 
        a.uniq
    end 
    
end