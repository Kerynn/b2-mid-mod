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
end