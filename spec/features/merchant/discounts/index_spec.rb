require 'rails_helper'

RSpec.describe "As a merchant" do
  it "can see discounts for that merchant" do
    merchant_1 = Merchant.create(name: 'Megans Creatures', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    merchant_2 = Merchant.create(name: 'Brians Animals', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    m_user = merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant@example.com', password: 'password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

    discount_1 = merchant_1.discounts.create!(name: "Ten Item Discount", percentage_off: 10, minimum_quantity: 10)
    discount_2 = merchant_1.discounts.create!(name: "Twenty Item Discount", percentage_off: 20, minimum_quantity: 20)
    discount_3 = merchant_2.discounts.create!(name: "Thirty Item Discount", percentage_off: 30, minimum_quantity: 30)

    visit "/merchant/discounts"

    expect(page).to have_content(discount_1.name)
    expect(page).to have_content("Percentage: #{discount_1.percentage_off}")
    expect(page).to have_content("Minimum Quantity: #{discount_1.minimum_quantity}")
    expect(page).to have_content(discount_2.name)
    expect(page).to have_content("Percentage: #{discount_2.percentage_off}")
    expect(page).to have_content("Minimum Quantity: #{discount_2.minimum_quantity}")
    expect(page).to_not have_content(discount_3.name)
    expect(page).to_not have_content(discount_3.percentage_off)
    expect(page).to_not have_content(discount_3.minimum_quantity)
  end
end
