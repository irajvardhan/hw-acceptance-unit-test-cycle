require 'rails_helper'

RSpec.describe MoviesHelper do
  describe ".data_load" do
    let!(:movie1) { FactoryBot.create(:movie, title: "Batman Begins", rating: "R", description: "DC comic", release_date: "2008", director: "Unkown")}
    let!(:movie2) { FactoryBot.create(:movie, title: "Wonder Woman", rating: "G", description: "A super hero  movie", release_date: "2017", director: "Unkown")}
  end

  describe 'helper methods' do
    it 'should return odd' do
      response = oddness(1)
      expect(response).to eq("odd")
    end
  end

  describe 'helper methods' do
    it 'should return even' do
      response = oddness(2)
      expect(response).to eq("even")
    end
  end
end