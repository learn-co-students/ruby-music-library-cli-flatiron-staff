class MusicImporter
  attr_reader :path, :files

  def initialize(path)
    @path = path
    @files = Dir.entries(path).select { |file| file != '.' && file != '..' }
  end

  def import
    @files.each { |file| Song.create_from_filename(file) }
  end
end