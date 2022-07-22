# El modelo receta
class Recipe
  attr_reader :status, :name, :description, :prep_time, :rating

  def initialize(attributes = {})
    @status = attributes[:status] || false
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @rating = attributes[:rating]
  end

  def mark!
    @status = !@status
  end
end
