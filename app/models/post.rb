class Post < ApplicationRecord
  belongs_to :user
  has_many :products
  has_many :categories, through: :products

  accepts_nested_attributes_for :products,
   reject_if: :all_blank,
   allow_destroy: true
  validates :title, presence: true

  scope :search, ->(query) do
    return Post.all if query.blank?

    where("lower(title) LIKE ?", "%#{query.downcase}%")
  end

  def owned_by?(owner)
    return false unless owner.is_a?(User)
    user == owner
  end
end 