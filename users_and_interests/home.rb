require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'

before do
  @profiles = YAML.load_file('data/users.yaml')
  @names = @profiles.keys.map(&:to_s)
end

helpers do
  def generate_footer
    user_num = @names.count
    interest_num = count_interests
    "There are #{user_num} users with a total of #{interest_num} interests."
  end

  def count_interests
    @profiles.reduce(0) do |sum, (_, profile)|
      sum + profile[:interests].count
    end
  end
end

get '/' do
  redirect to('/users')
end

get '/users' do
  erb :users
end

get '/users/:name' do
  @name = params[:name]
  @email = @profiles[@name.to_sym][:email]
  @interests = @profiles[@name.to_sym][:interests]
  erb :user_detail
end