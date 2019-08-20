class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine

  validates :title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time,
   :ingredients, :cook_method, presence: {message:'é campo obrigatório'}

  def cook_time_min
    "#{cook_time} minutos"
  end
end
