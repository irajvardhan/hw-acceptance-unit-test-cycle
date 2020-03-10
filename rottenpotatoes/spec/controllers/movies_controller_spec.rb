require 'rails_helper'
describe MoviesController do
  before(:each) do
    @movie1 = FactoryBot.create(:movie, id: 1, title: "Inception", rating: "UG", description: "", release_date: "2010", director: "Christopher Nolan")
    @movie2 = FactoryBot.create(:movie, id: 2, title: "Titanic", rating: "PG", description: "", release_date: "1997", director: "James Cameron")
    @movie3 = FactoryBot.create(:movie, id: 3, title: "Fight Club", rating: "R", description: "underground club", release_date: "1999")
  end

  describe 'preexisting method test in before(:each)' do
    it 'should call find model method' do
      Movie.should_receive(:find).with('1')
      get :show, :id => '1'
    end

    it 'should render page correctoy' do
      get :index
      response.should render_template :index
    end

    it 'should redirect to appropriate url' do
      get :index, 
          {},    
          {ratings: {G: 'G', PG: 'PG'}}
      response.should redirect_to :ratings => {G: 'G', PG: 'PG'}
    end

    it 'should redirect to appropriate sort title url' do
      get :index,             
          {},                
          {sort: 'title'}   
      response.should redirect_to :sort => 'title'
    end

    it 'should redirect to appropriate sort release_date url' do
      get :index,          
          {},             
          {sort: 'release_date'}
      response.should redirect_to :sort => 'release_date'
    end

    it 'should create movie and redirect' do
      post :create,
           {:movie => { :title => "The Godfather", :description => "Life of Don Corleone", :director => "Mario Puzo", :rating => "R", :release_date =>"01/05/1971"}}
      response.should redirect_to movies_path
      expect(flash[:notice]).to be_present

    end
    it 'should render two movies' do
      get :index
      response.should render_template :index
    end

    it 'should update render edit view' do
      Movie.should_receive(:find).with('1')
      get :edit,
          {id: '1'}

    end

    it 'should update data correctly' do
      Movie.stub(:find).and_return(@movie1)
      put :update,
          :id => @movie1[:id],
          :movie => {title: "Godfather 2", rating: "UG", description: "part 2 of Gofather", release_date: "01/05/1971", director: "Mario Puzo"}
      expect(flash[:notice]).to be_present
    end
  end

  describe 'director methods test in before(:each)' do
    it 'should call appropriate model method' do
      Movie.should_receive(:same_movies).with(@movie2[:id], {'director' => @movie2[:director]})
      get :same, :id => @movie2[:id], :by_dir => 'director'
    end

    it 'should redirect to homepage on invalid no director request' do
      Movie.should_receive(:same_movies).with(@movie3[:id], {'director' => @movie3[:director]})
      Movie.stub(:same_movies).with(@movie3[:id], {'director' => @movie3[:director]}).and_return(nil)
      get :same, :id => @movie3[:id], :by_dir => 'director'
      expect(flash[:notice]).to be_present
      response.should redirect_to movies_path
    end
  end
end
