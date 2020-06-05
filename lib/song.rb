require 'pry'

class Song
    attr_accessor :name 
    attr_reader :artist, :genre
  
    @@all = []
  
    def artist=(artist)
      @artist = artist
      artist.add_song(self)
    end 

    def genre=(genre)
      @genre = genre
      genre.songs.include?(self) ? return : genre.songs << self
    end 

    def initialize(name, artist = nil, genre = nil)
      @name = name
      if artist
        self.artist = artist
      end 
      if genre 
        self.genre = genre
      end
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
      song = Song.new(name)
      song.save
      song
    end

    def self.find_by_name(name)
      self.all.find { |song| song.name == name }
    end 
  
    def self.find_or_create_by_name(name)
      self.find_by_name(name) || self.create(name)
    end 

    def self.new_from_filename(filename)
      a = filename.split(" - ")
      name = a[1]
      artist = Artist.find_or_create_by_name(a[0])
      genre = Genre.find_or_create_by_name(a[2].chomp(".mp3"))
      self.new(name, artist, genre)
    end 

    def self.create_from_filename(filename)
      self.new_from_filename(filename).save
    end 

  end
  