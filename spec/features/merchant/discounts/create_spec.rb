require 'rails_helper'

RSpec.describe "Discounts Create Page" do
  it "can see a link to add a new discount" do
    merchant_1 = Merchant.create(name: 'Megans Creatures', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    m_user = merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant@example.com', password: 'password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

    visit "/merchant/discounts"

    click_link "New Discount"

    expect(current_path).to eq("/merchant/discounts/new")

    fill_in "Name", with: "Five Item Discount"
    fill_in :percentage_off, with: 5
    fill_in :minimum_quantity, with: 5

    click_on "Create Discount"

    expect(current_path).to eq("/merchant/discounts")
    expect(page).to have_content("Five Item Discount")
  end
end
