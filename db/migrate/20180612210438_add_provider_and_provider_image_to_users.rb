class AddProviderAndProviderImageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :provider_image, :string
  end
end
