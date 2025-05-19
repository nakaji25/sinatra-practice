# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

FILE_PATH = 'memos/memo.json'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def open_memos(file_path)
  JSON.parse(File.open(file_path).read, symbolize_names: true)
end

def save_memos(file_path)
  File.open(file_path, 'w') { |file| JSON.dump(@memos, file) }
end

before do
  @memos = open_memos(FILE_PATH)
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  erb :memos
end

get '/memos/:id' do
  @memos.each do |memo|
    @memo = memo if memo[:id] == params[:id]
  end
  erb :content
end

get '/new-memos' do
  erb :new_memo
end

get '/memos/:id/edit' do
  @memos.each do |memo|
    @memo = memo if memo[:id] == params[:id]
  end
  erb :edit
end

post '/memos' do
  @title = params[:title]
  @content = params[:content]
  latest_memo = @memos.max { |x, y| (x[:id] <=> y[:id]) }
  @memos[@memos.size] = { id: (latest_memo[:id].to_i + 1).to_s, title: @title, content: @content }
  save_memos(FILE_PATH)
  redirect '/memos'
end

patch '/memos/:id' do
  @memos[params[:id].to_i][:title] = params[:title]
  @memos[params[:id].to_i][:content] = params[:content]
  save_memos(FILE_PATH)
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  @memos = open_memos(FILE_PATH)
  @memos.each_with_index do |memo, i|
    @memos.delete_at(i) if memo[:id] == params[:id]
  end

  save_memos(FILE_PATH)
  redirect '/memos'
end
