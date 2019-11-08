class Artist
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    all_genres = @songs.map { |song| song.genre }
    all_genres.uniq
  end

  def save
    self.class.all << self
  end

  def add_song(song)
    song.artist = self if song.artist.nil?
    @songs << song unless @songs.include?(song)
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end
end