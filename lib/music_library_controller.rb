class MusicLibraryController

    def initialize(path = "./db/mp3s")
        MusicImporter.new(path).import
    end 

    def call
       puts "Welcome to your music library!"
       puts "To list all of your songs, enter 'list songs'."
       puts "To list all of the artists in your library, enter 'list artists'."
       puts "To list all of the genres in your library, enter 'list genres'."
       puts "To list all of the songs by a particular artist, enter 'list artist'."
       puts "To list all of the songs of a particular genre, enter 'list genre'."
       puts "To play a song, enter 'play song'."
       puts "To quit, type 'exit'."
       puts "What would you like to do?"
        response = gets 
        if response == 'list songs'
            list_songs
        elsif response == 'list artists'
            list_artists  
        elsif response == 'list genres'
            list_genres
        elsif response == 'list artist'
            list_songs_by_artist
        elsif response == 'list genre'
            list_songs_by_genre
        elsif response == 'list songs'
            list_songs
        elsif response == 'play song'
            play_song
        end 
       while response != "exit"
        puts "What would you like to do?"
        response = gets
        end 
    end 

    def list_songs
        sorted = Song.all.sort_by! {|song| song.name}
        sorted.each_with_index { |song, index| 
        puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    }
    end 

    def list_artists
        sorted = Artist.all.sort_by! {|artist| artist.name}
        sorted.each_with_index { |artist, index| 
        puts "#{index+1}. #{artist.name}"
    }
    end 

    def list_genres
        sorted = Genre.all.sort_by! {|genre| genre.name}
        sorted.each_with_index { |genre, index| 
        puts "#{index+1}. #{genre.name}"
    }
    end 

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        response = gets.chomp
        artist = Artist.find_or_create_by_name(response)
        songs = artist.songs.sort_by! {|song| song.name}
        songs.each_with_index { |song, index| 
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
    }
    end 

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        response = gets.chomp
        genre = Genre.find_or_create_by_name(response)
        songs = genre.songs.sort_by! {|song| song.name}
        songs.each_with_index { |song, index| 
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
    }
    end 

    def play_song
        puts "Which song number would you like to play?"
        input = gets.to_i
        songs = Song.all.sort_by! {|song| song.name}
        if 0 < input && input < songs.size
        puts "Playing #{songs[input - 1].name} by #{songs[input - 1].artist.name}"
        end 
    end 

end 