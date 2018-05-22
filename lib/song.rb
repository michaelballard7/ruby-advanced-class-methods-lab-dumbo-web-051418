require 'pry'
class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

 # this is a method that detaches creation from the initialize method
  def self.create
    @@all << self.new
    @@all.last
  end

  # allows me to instantiate new objects by a name
  def self.new_by_name(name)
    person = self.new
    person.name = name
    @@all << person
    @@all.last
  end


  def self.create_by_name(name)
    self.new_by_name(name)
  end

  # allows me to find a song by using a name
  def self.find_by_name(name)
    self.all.detect{|song| song.name == name}
  end

  # determines if a it can find a song if not it creates a new instance using a name param
  def self.find_or_create_by_name(name)
    self.find_by_name(name) == nil ? self.create_by_name(name) : self.find_by_name(name)

  end

  # sorts the all array by key value using the &:shorcut
  def self.alphabetical
    self.all.sort_by(&:name)
  end

  def self.new_from_filename(file_data)
    data = file_data.split(" - ") # parses the original file by -
    artist_name = data[0] # accesses the first element of the returned array
    song_name = data[1].split(".")[0] # access the second element of the returned array and splits of at .
    song = self.create_by_name(song_name) # calls the create by name method to instantiate a new object
    song.artist_name = artist_name # sets the artist name to the instance of song
    song  # returns song
  end

  def self.create_from_filename(file_data)
    self.new_from_filename(file_data)
  end

  def self.destroy_all
    @@all.clear
  end

end
