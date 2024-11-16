class EmployeeTicketsController < ApplicationController
  def create
    employee = Employee.find(params[:id])
    ticket = Ticket.find(params[:ticket_id])
    EmployeeTicket.create(employee_id: employee.id, ticket_id: ticket.id)
    redirect_to "/employees/#{employee.id}"
  end
end