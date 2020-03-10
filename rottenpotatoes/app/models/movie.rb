class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.same_movies id, options
    movie_opt = options.select { |key,value| value != nil and value != '' }

    if movie_opt.keys.length == 0
      return []
    end

    build = all()
    movie_opt.each do |key, val|
      build = build.where("%s = '%s'" % [key, val])
    end
    build = build.where("id != '%s'" % [id])
    return build
  end
  
end

