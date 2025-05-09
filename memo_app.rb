# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

before do
  @memos = JSON.parse(open('public/memo.json').read)
end

get '/' do
  erb :index
end

get '/memos/:id' do
  @memo = @memos[params[:id].to_i]
  erb :content
end
