class MusicLibraryController
  def initialize(path = './db/mp3s')
    mi = MusicImporter.new(path)
    mi.import
  end

  def call
    puts "Welcome to your music library!"
    self.class.print_options
    puts "What would you like to do?"
    print "> "
    input = ''

    until input == 'exit'
      input = gets.strip
      handle_input(input)
    end

    input
  end

  def list_songs
    songs = sort_by_name(Song)
    
    songs.each_with_index do |song, idx| 
      puts "#{idx + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artists = sort_by_name(Artist)
    artists.each_with_index { |artist, idx| puts "#{idx + 1}. #{artist.name}" }
  end

  def list_genres
    genres = sort_by_name(Genre)
    genres.each_with_index { |genre, idx| puts "#{idx + 1}. #{genre.name}" }
  end

  def list_songs_by_artist
    input = get_input("Please enter the name of an artist:")
    artist = Artist.find_by_name(input)

    return if artist.nil?
    
    artist.songs.sort_by(&:name).each_with_index do |song, idx| 
      puts "#{idx + 1}. #{song.name} - #{song.genre.name}" 
    end
  end

  def list_songs_by_genre
    input = get_input("Please enter the name of a genre:")
    genre = Genre.find_by_name(input)

    return if genre.nil?

    genre.songs.sort_by(&:name).each_with_index do |song, idx|
      puts "#{idx + 1}. #{song.artist.name} - #{song.name}"
    end
  end

  def play_song
    input = get_input("Which song number would you like to play?")
    return unless /[1-9]+/.match?(input) && input.to_i < Song.all.length

    song = Song.all[input.to_i]
    puts "Playing #{song.name} by #{song.artist.name}"
  end

  def self.print_options
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
  end

  private

  def handle_input(input)
    case input
    when 'list songs'
      list_songs
    when 'list artists'
      list_artists
    when 'list genres'
      list_genres
    when 'list artist'
      list_songs_by_artist
    when 'list genre'
      list_songs_by_genre
    when 'play song'
      play_song
    end
  end

  def get_input(msg)
    puts msg
    print "> "
    gets.strip
  end

  def sort_by_name(collection)
    collection.all.sort_by(&:name)
  end
end