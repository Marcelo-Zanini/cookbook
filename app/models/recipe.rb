class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user
  has_many :list_items
  has_many :recipe_lists, through: :list_items
  has_one_attached :picture

  validates :title, :difficulty, :cook_time, :picture,
   :ingredients, :cook_method, presence: {message:'é campo obrigatório'}

  enum status: {pending: 0, active: 1, rejected: 70}

  def cook_time_min
    "#{cook_time} minutos"
  end

  def owner?(user)
    return true if self.user == user
    false
  end
end
