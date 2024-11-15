require "rails_helper"

RSpec.describe Ticket, type: :model do
    describe "relationships" do
        it { should have_many :employee_tickets }
    end
end 