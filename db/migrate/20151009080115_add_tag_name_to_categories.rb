class AddTagNameToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :tag_name, :string
    Category.all.each do |category|
      category.save
    end
  end
end
