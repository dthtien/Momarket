class Product < ApplicationRecord
  belongs_to :post, required: false
  belongs_to :category 
  
  validates :name, :description, presence: true
  validates :price, presence: true, numericality: true
  has_attached_file :product_image, 
    styles: { 
     medium: "300x300>", 
     thumb: "100x100>" },
     default_url: "/images/:style/missing.png"
  validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\z/
end
 