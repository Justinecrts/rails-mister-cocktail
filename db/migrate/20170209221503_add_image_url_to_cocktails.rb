class AddImageUrlToCocktails < ActiveRecord::Migration[5.0]
  def change
    add_column :cocktails, :image_url, :string
  end
end
