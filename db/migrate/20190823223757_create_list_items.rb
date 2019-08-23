class CreateListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :list_items do |t|
      t.references :recipe_list, foreign_key: true
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
