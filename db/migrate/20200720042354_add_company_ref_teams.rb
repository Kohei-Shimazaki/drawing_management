class AddCompanyRefTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :company, foreign_key: true    
  end
end
