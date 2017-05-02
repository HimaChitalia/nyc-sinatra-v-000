class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    figure = Figure.create(params[:figure])
    # binding.pry
    if !params[:title][:name].nil?
      figure.titles << Title.find_or_create_by(name: params[:title][:name])
      # figure.title = Title.find_or_create_by(name: params[:title])
    else
      figure.titles << Title.find(params[:figure][:title_ids])
    end
    if !params[:landmark][:name].nil?
      figure.landmarks << Landmark.find_or_create_by(name: params[:landmark][:name])
    else
      figure.landmarks << Landmark.find(params[:figure][:landmark_ids])
    end
    # binding.pry
    figure.save
    "A new figure is created."
    # {"figure"=>
 #  {"name"=>"Handsome figure", "title_ids"=>["3"], "landmark_ids"=>["6"]},
 # "title"=>{"name"=>""},
 # "landmark"=>{"name"=>"", "year_completed"=>""}}
    redirect to "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    # binding.pry
    # "Figure has been edited"
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    if !params[:title][:name].nil?
      @figure.titles << Title.find_or_create_by(name: params[:title][:name])
    else
      @figure.titles << Title.find(params[:figure][:title_ids])
    end
    if !params[:landmark][:name].nil?
      @figure.landmarks << Landmark.find_or_create_by(name: params[:landmark][:name])
    else
      @figure.landmarks << Landmark.find(params[:figure][:landmark_ids])
    end
    @figure.save
   #    {"_method"=>"PATCH",
   # "figure"=>{"name"=>"Smart figure"},
   # "titles"=>["2"],
   # "landmarks"=>["3"],
   # "splat"=>[],
   # "captures"=>["6"],
   # "id"=>"6"}
  #  binding.pry
   redirect to "/figures/#{@figure.id}"
  end

end
