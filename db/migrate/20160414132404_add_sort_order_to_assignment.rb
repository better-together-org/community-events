class AddSortOrderToAssignment < ActiveRecord::Migration
  def change
    add_column :programme_item_assignments, :sort_order, :integer
    add_column :published_programme_item_assignments, :sort_order, :integer
  end
end
