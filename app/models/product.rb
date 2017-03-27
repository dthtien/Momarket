class Product < ApplicationRecord
  belongs_to :post, required: false
end
 