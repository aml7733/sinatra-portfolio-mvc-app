require 'pry'

class CoachController < ApplicationController
  get '/coaches/signup' do
    erb :'coaches/signup'
  end

  post '/coaches/signup' do
    binding.pry
    @coach = Coach.create(params[coach])
  end
end
