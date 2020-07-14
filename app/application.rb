class Song
 
  attr_accessor :title, :artist
 
  def initialize(title, artist)
    @title = title
    @artist = artist
  end
 
end



class Application
 
  @@songs = [Song.new("Sorry", "Justin Bieber"),
            Song.new("Hello","Adele")]
 
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path == "/songs"
      @@songs.each do |s|
        resp.write "#{s.title} by #{s.artist}\n"
      end

    elsif req.path.match(/songs/)
 
      song_title = req.path.split("/songs/").last #turn/songs/Sorry into Sorry
      song = @@songs.find{|s| s.title == song_title} 
      resp.write song? song.artist : "There is no #{req.path}"

    end
 
    resp.finish
  end
end



