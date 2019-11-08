class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.genre = genre unless genre.nil?
    self.artist= artist unless artist.nil?
  end

  def save
    self.class.all << self
  end

  def genre=(genre)
    @genre = genre
    @genre.songs << self unless @genre.songs.include?(self)
  end

  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end

  def self.parse_filename(filename)
    song_data = filename.split(' - ')
    song_title = song_data[1]
    song_artist = song_data[0]
    song_genre = song_data.last.split('.')[0]
    { title: song_title, artist: song_artist, genre: song_genre }
  end

  def self.new_from_filename(filename)
    song_data = parse_filename(filename)
    song = find_or_create_by_name(song_data[:title])
    song.artist = Artist.find_or_create_by_name(song_data[:artist])
    song.genre = Genre.find_or_create_by_name(song_data[:genre])
    song
  end

  def self.create_from_filename(filename)
    new_from_filename(filename)
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end
end