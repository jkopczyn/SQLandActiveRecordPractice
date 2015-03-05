class ChangeUrlLength < ActiveRecord::Migration
  def up
    change_column :shortened_urls, :long_url, :string, limit: 1024
  end

  def down
    change_column :shortened_urls, :long_url, :string, limit: 255
  end
end
