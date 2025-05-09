# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

get '/' do
  @memos = JSON.parse(open('public/memo.json').read)
  erb :index
end
