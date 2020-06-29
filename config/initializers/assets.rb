# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.precompile += %w[
  home.css
  devise/confirmations.css
  devise/unlocks.css
  managers/*.js
  managers/confirmations.css
  managers/cookedstates.css
  managers/cuisines.css
  managers/foodcategories.css
  managers/foodstuffs.css
  managers/ingredients.css
  managers/procedures.css
  managers/rawmaterials.css
  managers/registrations.css
  managers/sessions.css
  users/cuisines.css
  users/sessions.css
  users/registrations.css
]
