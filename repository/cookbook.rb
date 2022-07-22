require 'csv'
require_relative '../model/recipe'

# Repositorio de recetas
class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def find(index)
    @recipes[index]
  end

  def mark_recipe(index)
    recipe = @recipes[index]
    recipe.mark!
    save_csv
  end

  def update(index, attributes = {})
    recipe = @recipes[index]
    recipe.save(attributes)
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def save
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: true) do |row|
      status = row[0] == 'true'
      attributes = { status: status, name: row[1], description: row[2], prep_time: row[3], rating: row[4] }
      @recipes << Recipe.new(attributes)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb', force_quotes: true) do |csv|
      csv << %w[status name description preparation_time rating]
      @recipes.each { |recipe| csv << [recipe.status, recipe.name, recipe.description, recipe.prep_time, recipe.rating] }
    end
  end
end
