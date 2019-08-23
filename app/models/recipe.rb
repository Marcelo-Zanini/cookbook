class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user

  validates :title, :difficulty, :cook_time,
   :ingredients, :cook_method, presence: {message:'é campo obrigatório'}

  def cook_time_min
    "#{cook_time} minutos"
  end

  def owner?(user)
    return true if self.user == user
    false
  end
end
