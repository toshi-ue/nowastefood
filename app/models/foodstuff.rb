class Foodstuff < ApplicationRecord
  belongs_to :cuisine
  belongs_to :cookedstate
  belongs_to :ingredient
  belongs_to :rawmaterial
end
