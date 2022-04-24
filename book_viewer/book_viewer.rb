require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @title = "Book Shelf"
  @chapters = File.readlines("data/toc.txt")
  # @chapters = File.read("data/toc.txt").split("\n")
  erb :home
  # This also works:
  # erb :home, :locals => {:title => "Book Shelf"}
end

get "/chapters/1" do
  @title = "Chapter 1"
  @content = File.read("data/chp1.txt")
  @chapters = File.readlines("data/toc.txt")

  erb :chapter
end
