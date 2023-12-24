class CourseCategory < ProductCategory
  self.table_name='product_categories'
  attribute :pc_type, :string, default: 'course'
end
