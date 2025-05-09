# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

before do
  @memos = JSON.parse(open('public/memo.json').read)
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @memos = JSON.parse(open('public/memo.json').read)
  erb :memos
end

get '/memos/:id' do
  @memo = @memos[params[:id].to_i]
  erb :content
end

get '/new-memos' do
  erb :new_memo
end

post '/memos' do
  @title = params[:title]
  @content = params[:content]
  File.open('public/memo.json', 'w') do |file|
    @memos[@memos.size] = { id: @memos.size.to_s, title: @title, content: @content }
    JSON.dump(@memos, file)
  end
  redirect '/'
end
