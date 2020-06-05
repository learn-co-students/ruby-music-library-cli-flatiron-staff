class MusicImporter
    attr_reader :path

    def initialize(file_path)
        @path = file_path
    end 

    def files 
        Dir["#{self.path}/*"].each { |file|
        file.slice! "#{self.path}/"
      }
    end 

    def import
        self.files.each { |file| Song.create_from_filename(file)}
    end 

end 