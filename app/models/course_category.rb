class CourseCategory < ProductCategory
  self.table_name = 'product_categories'

  has_many :products, foreign_key: :product_category_id
  has_many :courses, -> { where.not(id: nil) }, through: :products

  default_scope {
    joins(products: :course).distinct
  }
end