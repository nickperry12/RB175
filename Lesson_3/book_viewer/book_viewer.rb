require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @title = ["Home Page", "The Adventures of Sherlock Holmes", "Table of Contents"].sample
  @contents = File.readlines("./data/toc.txt")

  erb :home
end

get "/chapters/:number" do
  @ch_number = params[:number]
  @title = "Chapter #{@ch_number}"
  @contents = File.readlines("./data/toc.txt")
  @chapter = File.read("./data/chp#{@ch_number}.txt")

  erb :chapter
end

get "/show/:name" do
  params[:name]
end
