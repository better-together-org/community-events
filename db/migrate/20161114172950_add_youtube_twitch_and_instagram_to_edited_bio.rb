class AddYoutubeTwitchAndInstagramToEditedBio < ActiveRecord::Migration
  def change
    add_column :edited_bios, :twitch, :text, {:default => nil}
    add_column :edited_bios, :youtube, :text, {:default => nil}
    add_column :edited_bios, :instagram, :text, {:default => nil}
  end
end
