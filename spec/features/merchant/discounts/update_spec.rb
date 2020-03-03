require 'rails_helper'

RSpec.describe "Discount Update Page" do
  describe "as a merchant" do
    it "can update an existing discount" do
      merchant_1 = Merchant.create(name:'Megans Creatures', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      m_user = merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant@example.com', password: 'password')
      discount_1 = merchant_1.discounts.create(name: "Ten Item Discount", percentage_off: 20, minimum_quantity: 10)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

      visit "/merchant/discounts"

      click_link "Edit Discount"

      expect(current_path).to eq("/merchant/discounts/#{discount_1.id}/edit")

      fill_in :name, with: "new discount"
      fill_in :percentage_off, with: 10
      fill_in :minimum_quantity, with: 10

      click_on "Update Discount"

      expect(current_path).to eq("/merchant/discounts")

      within "#discount#{discount_1.id}" do
        expect(page).to have_content("new discount")
        expect(page).to have_content("Percentage: 10")
        expect(page).to have_content("Minimum Quantity: 10")
      end
    end
  end
end
