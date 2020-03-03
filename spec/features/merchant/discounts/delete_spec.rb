require 'rails_helper'

RSpec.describe "Discounts Delete Page" do
  describe "as a merchant" do
    it "can delete a discount" do
      merchant_1 = Merchant.create(name:'Megans Creatures', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      m_user = merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant@example.com', password: 'password')
      discount_1 = merchant_1.discounts.create(name: "Ten Item Discount", percentage_off: 10, minimum_quantity: 10)
      discount_2 = merchant_1.discounts.create(name: "Twenty Item Discount", percentage_off: 20, minimum_quantity: 20)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

      visit "/merchant/discounts"

      within "#discount#{discount_2.id}" do
        click_on "Delete Discount"
      end

      expect(current_path).to eq("/merchant/discounts")
      expect(page).to have_content(discount_1.name)
      expect(page).to_not have_content(discount_2.name)
    end
  end
end
