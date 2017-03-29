class Post < ApplicationRecord
  belongs_to :user
  has_many :products

  accepts_nested_attributes_for :products,
   reject_if: :all_blank,
   allow_destroy: true
  validates :title, presence: true

  def owned_by?(owner)
    return false unless owner.is_a?(User)
    user == owner
  end
end 