require "rails_helper"

RSpec.describe "the Employee show page" do
  before(:each) do
    @marketing_department = Department.create!(name: "Marketing", floor: "basement")
    @jim = @marketing_department.employees.create!(name: "Jim", level: 8)
    @ticket1 = @jim.tickets.create!(subject: "sign a new client", age: 7)
    @ticket2 = @jim.tickets.create!(subject: "create presentation", age: 2)
    @ticket3 = @jim.tickets.create!(subject: "test product", age: 5)
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
    end
  end
end