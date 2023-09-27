require "sinatra"
require "tilt/erubis"
require "sinatra/reloader"
require "yaml"

before do
  @users_data = Psych.load_file("./data/users.yaml")
  @list_of_users = get_list_of_users(@users_data)
  @total_interests = get_total_interests(@users_data)
  @total_users = @users_data.keys.size
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :users
end

get "/users/:name" do
  @name = params[:name].to_s
  @user_email = @users_data[@name.to_sym][:email]
  @user_interests = @users_data[@name.to_sym][:interests].map(&:capitalize).join(', ')
  @non_current_users = get_all_users_but_current(@list_of_users, @name)

  erb :user_profile
end

helpers do
  def get_list_of_users(data)
    list = []

    data.each_key do |key|
      list << key.to_s.capitalize
    end

    list
  end

  def get_all_users_but_current(list, current)
    list.select do |user|
      user != current.capitalize
    end
  end

  def get_total_interests(hash)
    total_interests = 0

    hash.each_key do |key|
      total_interests += hash[key][:interests].size
    end

    total_interests
  end
end
