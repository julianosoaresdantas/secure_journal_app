class RemoveTwoFactorSecretKeyFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :two_factor_secret_key, :string
  end
end
