class CreateEmployeeTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :employee_tickets do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
