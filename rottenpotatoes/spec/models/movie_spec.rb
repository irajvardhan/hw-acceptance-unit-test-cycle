require 'rails_helper'

RSpec.describe Movie, type: :model do

  before(:each) do
    @movie1 = FactoryBot.create(:movie, id: 1, title: "t1", rating: "R", description: "d", release_date: "NA", director: "D1")
    @movie2 = FactoryBot.create(:movie, id: 2, title: "t2", rating: "R", description: "e", release_date: "NA", director: "D1")
    @movie3 = FactoryBot.create(:movie, id: 3, title: "t3", rating: "G", description: "s", release_date: "test", director: "D1")
    @movie4 = FactoryBot.create(:movie, id: 4, title: "t4", rating: "R", description: "c", release_date: "check")
  end

  describe 'director methods test for model in before(:each)' do
    it 'should return similar movie' do
      Movie.same_movies(@movie1[:id], {director: @movie1[:director]}).should == [@movie2, @movie3]
    end

    it 'should return empty relation' do
      Movie.same_movies(@movie4[:id], {director: @movie4[:director]}).should == []
    end
  end
end 
