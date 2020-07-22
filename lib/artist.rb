class Artist 
	extend Concerns::Findable

	attr_accessor :name , :songs

	@@all = []

	def initialize(name)
		@name = name 
		@songs = []
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
		a = Artist.new(name)
		a.save 
		a
	end

	def add_song(song)
		if song.artist == nil
			song.artist = self 
		else
			nil
		end
		if @songs.include?(song)
			nil
		else
			@songs << song 
		end
		song
	end

	def songs 
		@songs 
	end

	def genres 
		songs.map {|song| song.genre}.uniq
	end
end