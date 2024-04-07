class AddSortOrderVenue < ActiveRecord::Migration
  def change
    add_column :venues, :sort_order, :integer
    add_column :published_venues, :sort_order, :integer
    add_column :published_rooms, :sort_order, :integer
  end
end
