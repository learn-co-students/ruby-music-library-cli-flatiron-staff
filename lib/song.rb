class Song

  attr_accessor :name, :artist, :genre

  extend Concerns::Findable

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    new_song = Song.new(name)
    new_song.save
    new_song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

#   def self.new_from_filename(filename)
#       file = filename.split(" - ")
#       artist_name = file[0]
#       song_name = file[1]
#       genre_name = file[2].gsub(".mp3", "")
#
#       artist = Artist.find_or_create_by_name(artist_name)
#       genre = Genre.find_or_create_by_name(genre_name)
#
#       self.new(song_name, artist, genre)
#     end
#
#     def self.create_from_filename(filename)
#       # new_from_filename(filename).tap {|song| song.save}
#       song = self.new_from_filename(filename)
# +     song.save
#     end

  def self.new_from_filename(filename)
    data = filename.split(" - ")
    artist_name = data[0]
    song_name = data[1]
    genre_name = data[2].gsub(".mp3", "")
    # binding.pry
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  # def self.find_by_name(name)
  #   self.all.detect {|song| song.name}
  # end
  #
  # def self.find_or_create_by_name(name)
  #   self.find_by_name(name) || self.create(name)
  # end

end
