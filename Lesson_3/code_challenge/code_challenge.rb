require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'

get "/" do
  @list = Dir.glob("public/*").map { |file| File.basename(file) }.sort
  @list.reverse! if params[:sort] == "desc"
  erb :list
end

get "/sample1" do
  @file = 
  @content = File.read("./public/sample1.txt")
end

get "/sample2" do
  @content = File.read("./public/sample2.txt")
end

get "/sample3" do
  @content = File.read("./public/sample3.txt")
end

get "/sample4" do
  @content = File.read("./public/sample4.txt")
end

get "/sample5" do
  @content = File.read("./public/sample5.txt")
end

