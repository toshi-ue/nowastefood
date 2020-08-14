require 'active_record'

namespace :seed_sample do
  # 05_ingredient.rb
  ingredients = Ingredient.all
  SeedFu::Writer.write("db/afixtures/05_ingredient.rb", class_name: "Ingredient", seed_type: :seed_once) do |writer|
    ingredients.each do |ig|
      writer << ig.attributes.except("created_at", "updated_at")
    end
  end

  # 06_rawmaterial.rb
  rawmaterials = Rawmaterial.all
  SeedFu::Writer.write("db/afixtures/06_rawmaterial.rb", class_name: "Rawmaterial", seed_type: :seed_once) do |writer|
    rawmaterials.each do |rm|
      writer << rm.attributes.except("created_at", "updated_at")
    end
  end

  # 07_cookedstate.rb
  cookedstates = Cookedstate.all
  SeedFu::Writer.write("db/afixtures/07_cookedstate.rb", class_name: "Cookedstate", seed_type: :seed_once) do |writer|
    cookedstates.each do |cs|
      writer << cs.attributes.except("created_at", "updated_at")
    end
  end

  # 08_cuisine.rb
  cuisines = Cuisine.all
  SeedFu::Writer.write("db/afixtures/08_cuisine.rb", class_name: "Cuisine", seed_type: :seed_once) do |writer|
    cuisines.each do |cn|
      writer << cn.attributes.except("created_at", "updated_at")
    end
  end
end
