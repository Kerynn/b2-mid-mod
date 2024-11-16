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
end