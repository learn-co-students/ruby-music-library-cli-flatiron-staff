class Song 

		attr_accessor :name, :artist, :genre

	@@all = []

	def initialize(name, artist=nil, genre=nil)
		@name = name 
		self.artist=(artist) if artist != nil
		self.genre=(genre) if genre != nil
	end

	def self.all 
		@@all 
	end

	def save 
		@@all << self 
	end

	def self.destroy_all 
		@@all.clear 
	end

	def self.create(name)
		s = Song.new(name)
		s.save  
		s
	end

	def artist=(artist) 
		@artist = artist 
		artist.add_song(self)
	end

	def genre=(genre)
		@genre = genre 
		unless genre.songs.include?(self)
			genre.songs << self 
		end
	end

	def self.find_by_name(name)
		self.all.detect{|s| s.name == name}
	end

	def self.find_or_create_by_name(name)
		self.find_by_name(name) || self.create(name)
	end


	# def self.new_from_filename(filename)
	# 	song = self.find_or_create_by_name(filename.split(' - ')[1])
	# 	artist = Artist.find_or_create_by_name(filename.split(' - ')[0])
	# 	genre = Genre.find_or_create_by_name(filename.split(' - ')[2].gsub('.mp3',''))
	# 	song.artist = artist 
	# 	song.genre = genre
	# 	song
	# end

	  def self.new_from_filename(filename)
    filename_array = filename.split(" - ")
    artist = Artist.find_or_create_by_name(filename_array[0])
    genre = Genre.find_or_create_by_name(filename_array[2].chomp(".mp3"))
    song = self.new(filename_array[1], artist, genre)
    artist.add_song(song)
  end

	# def self.create_from_filename(filename) 
	# 	s = new_from_filename(filename)
	# 	s.save
	# end

	  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
    song
  end




end