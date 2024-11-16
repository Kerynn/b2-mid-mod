require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many(:tickets).through(:employee_tickets) }
  end

  describe "sort_tickets" do
    it "sorts the tickets from oldest to youngest" do
      marketing_department = Department.create!(name: "Marketing", floor: "basement")
      jim = marketing_department.employees.create!(name: "Jim", level: 8)
      ticket1 = jim.tickets.create!(subject: "sign a new client", age: 7)
      ticket2 = jim.tickets.create!(subject: "create presentation", age: 2)
      ticket3 = jim.tickets.create!(subject: "test product", age: 5)

      expect(jim.sort_tickets).to eq([ticket1, ticket3, ticket2])
    end
  end

  describe "oldest_ticket" do
    it "finds the oldest ticket for the employee" do
      marketing_department = Department.create!(name: "Marketing", floor: "basement")
      jim = marketing_department.employees.create!(name: "Jim", level: 8)
      ticket1 = jim.tickets.create!(subject: "sign a new client", age: 7)
      ticket2 = jim.tickets.create!(subject: "create presentation", age: 2)
      ticket3 = jim.tickets.create!(subject: "test product", age: 5)

      expect(jim.oldest_ticket).to eq(ticket1)
      expect(jim.oldest_ticket).to_not eq(ticket2)
      expect(jim.oldest_ticket).to_not eq(ticket3)
    end
  end

  describe "shared_tickets" do 
    xit "creates a unique list of shared employees for a ticket" do 
        marketing_department = Department.create!(name: "Marketing", floor: "basement")
        jim = marketing_department.employees.create!(name: "Jim", level: 8)
        ticket1 = jim.tickets.create!(subject: "sign a new client", age: 7)
        ticket2 = jim.tickets.create!(subject: "create presentation", age: 2)
        technology_department = Department.create!(name: "Technology", floor: "ground floor")
        dee = technology_department.employees.create!(name: "Dee", level: 4)
        samantha = technology_department.employees.create!(name: "Samantha", level: 9)
        dave = marketing_department.employees.create!(name: "Dave", level: 6)
        ticket3 = dave.tickets.create!(subject: "follow up on lead", age: 4)
        EmployeeTicket.create!(employee_id: dave.id, ticket_id: ticket2.id)
        EmployeeTicket.create!(employee_id: samantha.id, ticket_id: ticket2.id)
        EmployeeTicket.create!(employee_id: samantha.id, ticket_id: ticket3.id)
        EmployeeTicket.create!(employee_id: dee.id, ticket_id: ticket1.id)

        expect(dave.shared_tickets).to eq([samantha.name])
        expect(jim.shared_tickets).to eq([samantha.name, dave.name])
    end
  end
end