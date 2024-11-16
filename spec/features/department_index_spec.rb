require "rails_helper"

RSpec.describe "the Department index page" do
    it "should display the name and floor of the department" do
        marketing_department = Department.create!(name: "Marketing", floor: "basement")
        technology_department = Department.create!(name: "Technology", floor: "ground floor")
        leadership_department = Department.create!(name: "Leadership", floor: "top floor")

        visit "/departments"

        expect(page).to have_content(marketing_department.name)
        expect(page).to have_content(marketing_department.floor)
        expect(page).to have_content(technology_department.name)
        expect(page).to have_content(technology_department.floor)
        expect(page).to have_content(leadership_department.name)
        expect(page).to have_content(leadership_department.floor)
    end

    xit "should display the names of all employees of the department" do

    end
end