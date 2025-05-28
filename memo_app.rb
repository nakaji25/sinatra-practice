# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pg'

FILE_PATH = 'memos/memo.json'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

configure do
  set :db_connection, nil
  settings.db_connection = PG.connect(dbname: 'sinatra_db')
  result = settings.db_connection.exec("SELECT * FROM information_schema.tables WHERE table_name = 'memos'")
  if result.values.empty?
    connect_db.exec('CREATE TABLE memos (id SERIAL PRIMARY KEY, title VARCHAR(255), content TEXT)')
  end
end

after do
  settings.db_connection.finish if settings.db_connection && !settings.db_connection.finished?
  settings.db_connection = nil
end

def connect_db
  if settings.db_connection && !settings.db_connection.finished?
    settings.db_connection
  else
    settings.db_connection = PG.connect(dbname: 'sinatra_db')
  end
end

def open_memos
  connect_db.exec('SELECT * FROM memos')
end

def search_memo(id)
  result = connect_db.exec_params('SELECT * FROM memos WHERE id = $1;', [id])
  result.to_a[0]
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @memos = open_memos
  erb :memos
end

get '/memos/:id' do
  @memo = search_memo(params[:id])
  erb :content
end

get '/new-memos' do
  erb :new_memo
end

get '/memos/:id/edit' do
  @memo = search_memo(params[:id])
  erb :edit
end

post '/memos' do
  connect_db.exec_params('INSERT INTO memos(title, content) VALUES ($1, $2);', [params[:title], params[:content]])
  redirect '/memos'
end

patch '/memos/:id' do
  connect_db.exec_params('UPDATE memos SET title = $1, content = $2 WHERE id = $3;',
                         [params[:title], params[:content], params[:id]])
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  connect_db.exec_params('DELETE FROM memos WHERE id = $1;', [params[:id]])
  redirect '/memos'
end
