# entry point
require 'sinatra'
require 'json'
require 'faker'

require_relative './models/user'


# Retrieve all users from database.
get '/users' do
  all_users = []
  User.all.each do |user|
    info = JSON.parse(user.to_json)
    info.delete("password")
    info.to_json
    all_users.append(info)
  end
  {
      all_users: all_users
  }.to_json
end


# Create n users.
post '/users' do
  count = params[:n].to_i || 1
  if count > 30
    error 404, "Generate less than 30 users only"
  else
    count.times do
      User.create(name: Faker::Name.name, password: Faker::Internet.password, email: Faker::Internet.email, \
      bio: Faker::Lorem.paragraph(1, false, 3))
    end
  end
  status 200
  redirect "http://134.122.4.164/"
end


# Delete all users.
post '/users/destroy' do
  User.all.each do |user|
    User.delete(user)
  end
  status 200
  redirect "http://134.122.4.164/"
end

