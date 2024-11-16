require "rails_helper"

RSpec.describe "the Department index page" do
    before(:each) do 
        @marketing_department = Department.create!(name: "Marketing", floor: "basement")
        @technology_department = Department.create!(name: "Technology", floor: "ground floor")
        @leadership_department = Department.create!(name: "Leadership", floor: "top floor")
    end

    it "should display the name and floor of the department" do
        visit "/departments"

        expect(page).to have_content(@marketing_department.name)
        expect(page).to have_content(@marketing_department.floor)
        expect(page).to have_content(@technology_department.name)
        expect(page).to have_content(@technology_department.floor)
        expect(page).to have_content(@leadership_department.name)
        expect(page).to have_content(@leadership_department.floor)
    end

    it "should display the names of all employees of the department" do
        jim = @marketing_department.employees.create!(name: "Jim", level: 8)
        dave = @marketing_department.employees.create!(name: "Dave", level: 6)
        dee = @technology_department.employees.create!(name: "Dee", level: 4)
        samantha = @technology_department.employees.create!(name: "Samantha", level: 9)
        franny = @technology_department.employees.create!(name: "Franny", level: 7)
        frank = @leadership_department.employees.create!(name: "Frank", level: 10)

        visit "/departments"

        within "#department_#{@marketing_department.id}" do
            expect(page).to have_content(jim.name)
            expect(page).to have_content(dave.name)
            expect(page).to_not have_content(frank.name)
        end

        within "#department_#{@technology_department.id}" do
            expect(page).to have_content(dee.name)
            expect(page).to have_content(samantha.name)
            expect(page).to have_content(franny.name)
            expect(page).to_not have_content(jim.name)
        end

        within "#department_#{@leadership_department.id}" do
            expect(page).to have_content(frank.name)
            expect(page).to_not have_content(franny.name)
        end
    end
end