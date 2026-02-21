class LockerCategory < ProductCategory
  self.table_name = 'product_categories'

  has_many :products, foreign_key: :product_category_id
  has_many :lockers, -> { where.not(id: nil) }, through: :products

  default_scope {
    joins(products: :locker).distinct
  }
end