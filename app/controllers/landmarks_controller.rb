class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end


  get '/landmarks/new' do
    erb :'/landmarks/new'
  end


  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/edit'
  end


  post '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.name = params["landmark"]["name"]
    @landmark.year_completed = params["landmark"]["year_completed"]

    if !params[:title][:name].empty?
      @landmark.titles << Title.find_or_create_by(name: params[:title][:name])
    end

    if !params[:figure][:name].empty?
      @landmark.figures << Figure.find_or_create_by(name: params[:figure][:name])
    end

    @landmark.save
    redirect "/landmarks/#{@landmark.id}"
  end

  post '/landmarks' do
    @landmark = Landmark.create(params[:landmark])

    if !params[:title][:name].empty?
      @landmark.titles << Title.create(name: params[:title][:name])
    end

    if !params[:figure][:name].empty?
      @landmark.figures << Figure.create(name: params[:figure][:name])
    end

    @landmark.save
    redirect "/landmark/#{@landmark.id}"
  end

end
