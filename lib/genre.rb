class Genre
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
    all_artists = @songs.map { |song| song.artist }
    all_artists.uniq
  end
  
  def save
    self.class.all << self
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end
end