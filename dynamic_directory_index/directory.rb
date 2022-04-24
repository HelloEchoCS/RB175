require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get '/' do
  @file_list = []
  Dir.glob("./public/*").each do |item|
    @file_list << File.basename(item) if File.file?(item)
  end
  @file_list = (params['sort'] == 'desc') ? @file_list.sort.reverse : @file_list.sort
  erb :directory
end