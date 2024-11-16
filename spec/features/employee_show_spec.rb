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
    expect(page).to have_content(@employee.department.name)
  end

  it "shows a list of employee's tickets from oldest to newest" do
    visit "/employees/#{@jim.id}"
    
    expect(@ticket1).to appear_before(@ticket3)
    expect(@ticket3).to appear_before(@ticket2)
  end

  xit "shows the oldest ticket assigned separately" do

  end
end