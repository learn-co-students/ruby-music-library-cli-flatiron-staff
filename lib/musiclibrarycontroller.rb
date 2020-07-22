class MusicLibraryController

	def initialize(path='./db/mp3s')
		mi = MusicImporter.new(path)
		mi.import
	end

	def call 
		puts 'Welcome to your music library!'
		puts "To list all of your songs, enter 'list songs'."
		puts "To list all of the artists in your library, enter 'list artists'."
		puts "To list all of the genres in your library, enter 'list genres'."
		puts "To list all of the songs by a particular artist, enter 'list artist'."
		puts "To list all of the songs of a particular genre, enter 'list genre'."
		puts "To play a song, enter 'play song'."
		puts "To quit, type 'exit'."
		puts "What would you like to do?"
		input = gets.strip
		
		unless input == 'exit'
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
				else
					call
			end
		end 
	end

  def list_songs
    all_songs = Song.all
    # binding.pry
    all_songs.sort! {|song_1, song_2| song_1.name <=> song_2.name}
    all_songs.collect! {|song| "#{song.artist.name} - #{song.name} - " + song.genre.name}
    all_songs.each_with_index {|song, index| puts "#{index + 1}. " + song}
  end


	def list_artists
		Artist.all.sort {|a,b| a.name <=> b.name}.each_with_index do |a, i|
			puts "#{i+1}. #{a.name}"
		end
	end

	def list_genres
		Genre.all.sort {|a,b| a.name <=> b.name}.each_with_index do |g, i|
			puts "#{i+1}. #{g.name}"
		end
	end

	def list_songs_by_artist
		puts "Please enter the name of an artist:"
		artist_name = gets.strip
		if Artist.find_by_name(artist_name)
			artist1 = Artist.find_by_name(artist_name)
			artist1.songs.sort {|a,b| a.name <=> b.name}.each_with_index do |s,i|
				puts "#{i+1}. #{s.name} - #{s.genre.name}"
			end
		end
	end

	def list_songs_by_genre 
		puts 'Please enter the name of a genre:'
		genre_name = gets.strip
		if Genre.find_by_name(genre_name)
			genre1 = Genre.find_by_name(genre_name)
			genre1.songs.sort{|a,b| a.name <=> b.name}.each_with_index do |s,i|
				puts "#{i+1}. #{s.artist.name} - #{s.name}"
			end
		end
	end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip
    selected_index = input.to_i - 1
    if selected_index.between?(0, Song.all.length - 1)
      selected_song = Song.all.sort {|a, b| a.name <=> b.name}[selected_index]
      puts "Playing #{selected_song.name} by #{selected_song.artist.name}"
    end
  end




end