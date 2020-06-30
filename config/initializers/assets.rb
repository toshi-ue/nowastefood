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
  managers/cuisines.js
  managers/foodcategories.css
  managers/foodstuffs.css
  managers/foodstuffs.js
  managers/ingredients.css
  managers/procedures.css
  managers/rawmaterials.css
  managers/registrations.css
  managers/sessions.css
  managers/sessions.js
  users/cuisines.css
  users/sessions.css
  users/registrations.css
]

# TODO: 下2つの記述だと ActionView::Template::Error が発生する
# Rails.application.config.assets.precompile += [
#   '*.css',
#   '*.js',
#   'managers/*.css',
#   'managers/*.js',
#   'users/*.css',
#   'users/*.js',
#   'devise/*.css'
# ]

# Rails.application.config.assets.precompile += ['*.js', '*.css']
