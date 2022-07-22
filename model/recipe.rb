# El modelo receta
class Recipe
  attr_accessor :status, :name, :description, :prep_time, :rating

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

  def save(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @rating = attributes[:rating]
  end
end
