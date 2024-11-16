require "rails_helper"

RSpec.describe "the Employee show page" do
  before(:each) do
    @marketing_department = Department.create!(name: "Marketing", floor: "basement")
    @jim = @marketing_department.employees.create!(name: "Jim", level: 8)
    @dave = @marketing_department.employees.create!(name: "Dave", level: 6)
    @ticket1 = @jim.tickets.create!(subject: "sign a new client", age: 7)
    @ticket2 = @jim.tickets.create!(subject: "create presentation", age: 2)
    @ticket3 = @jim.tickets.create!(subject: "test product", age: 5)
    @ticket4 = @dave.tickets.create!(subject: "follow up on lead", age: 4)
    @ticket5 = Ticket.create!(subject: "clean fish tank", age: 3)
  end

  it "shows the employee name and department" do
    visit "/employees/#{@jim.id}"

    expect(page).to have_content(@jim.name)
    expect(page).to have_content(@jim.department.name)
  end

  it "shows a list of employee's tickets from oldest to newest" do
    visit "/employees/#{@jim.id}"

    expect(@ticket1.subject).to appear_before(@ticket3.subject)
    expect(@ticket3.subject).to appear_before(@ticket2.subject)
  end

  it "shows the oldest ticket assigned separately" do
    visit "/employees/#{@jim.id}"

    within "#oldest_ticket" do
      expect(page).to have_content(@ticket1.subject)
      expect(page).to_not have_content(@ticket2.subject)
    end
  end

  it "does not show other employee tickets" do 
    visit "/employees/#{@jim.id}"

    expect(page).to_not have_content(@ticket4.subject)

    visit "/employees/#{@dave.id}"

    expect(page).to_not have_content(@ticket3.subject)
    expect(page).to_not have_content(@ticket2.subject)
  end

  it "displays a form to add a new ticket" do
    visit "/employees/#{@dave.id}"

    fill_in :ticket_id, with: @ticket5.id
    expect(page).to have_button("Add Ticket to Employee")
  end

  it "redirects to employee show page with new ticket" do 
    visit "/employees/#{@dave.id}"

    expect(page).to_not have_content(@ticket5.subject)

    fill_in :ticket_id, with: @ticket5.id
    click_button "Add Ticket to Employee"

    expect(current_path).to eq("/employees/#{@dave.id}")
    expect(page).to have_content(@ticket5.subject)
  end

  xit "shows a unique list of employees who share tickets" do 
    technology_department = Department.create!(name: "Technology", floor: "ground floor")
    dee = technology_department.employees.create!(name: "Dee", level: 4)
    samantha = technology_department.employees.create!(name: "Samantha", level: 9)
    EmployeeTicket.create!(employee_id: @dave.id, ticket_id: @ticket2.id)
    EmployeeTicket.create!(employee_id: samantha.id, ticket_id: @ticket2.id)
    EmployeeTicket.create!(employee_id: samantha.id, ticket_id: @ticket4.id)
    EmployeeTicket.create!(employee_id: dee.id, ticket_id: @ticket1.id)
    
    # samantha, dave, and jim share ticket 2
    # samantha and dave share ticket 4, but samantha should only appear once on list
    # jim and dee share ticket 1

    visit "/employees/#{@dave.id}"

    within "#shared_tickets" do
      expect(page).to have_content("Shared Tickets List")
      expect(page).to have_content(samantha.name) # how to show only shows up once? 
      expect(page).to have_content(@jim.name)
      expect(page).to_not have_content(dee.name)
      # expect(page).to_not have_content(dave.name)
    end

    visit "/employees/#{@jim.id}"

    within "#shared_tickets" do
      expect(page).to have_content("Shared Tickets List")
      expect(page).to have_content(dee.name)
      expect(page).to_not have_content(@dave.name)
      expect(page).to_not have_content(samantha.name)
    end
  end
end