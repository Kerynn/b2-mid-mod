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
end