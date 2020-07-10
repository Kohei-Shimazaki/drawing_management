class AddAdminRefCompanies < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :admin, foreign_key: { to_table: :users }
  end
end
