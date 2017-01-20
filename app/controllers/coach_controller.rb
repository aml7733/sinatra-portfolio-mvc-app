class CoachController < ApplicationController
  get '/coaches/signup' do
    erb :'coaches/signup'
  end

  post '/coaches/signup' do
    @coach = Coach.create()
  end
end
