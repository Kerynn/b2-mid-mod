class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def sort_tickets
    tickets.order(age: :desc)
  end

  def oldest_ticket
    sort_tickets.first
  end

  def shared_tickets
    # ticket_ids = tickets.pluck(:id)
    
  end
end