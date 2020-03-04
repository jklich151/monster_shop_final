require 'rails_helper'

RSpec.describe "Order Discounts" do
  describe "can add the minimum items needed for the discount" do
    before :each do
        @user = User.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        @merchant_1 = Merchant.create(name: 'Megans Creatures', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @item_1 = @merchant_1.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 10, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 1000 )
        @discount_1 = @merchant_1.discounts.create!(name: "Ten Item Discount", percentage_off: 10, minimum_quantity: 10)
    end

    it "can see the discount shown in the cart" do
      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/cart"

      expect(page).to have_content("Quantity: 9")
      expect(page).to have_content("Subtotal: $90.00")
      expect(page).to_not have_content("Item Quantitiy Discount Applied!")

      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/cart"

      expect(page).to have_content("Quantity: 10")
      expect(page).to have_content("Subtotal: $90.00")
      expect(@item_1.item_qualifies_for_discount(10)).to eq([@discount_1])

      expect(page).to have_content("Item Quantitiy Discount Applied!")

      click_on "Check Out"

      expect(current_path).to eq("/profile/orders")

      expect(page).to have_content("Total: $90.00")
    end

    it "can handle multiple discounts" do
      @discount_2 = @merchant_1.discounts.create!(name: "Twenty Item Discount", percentage_off: 20, minimum_quantity: 20)

      visit "/items/#{@item_1.id}"
      click_on "Add to Cart"
      visit "/cart"

      18.times {click_on "More of This!"}

      expect(page).to have_content("Quantity: 19")
      expect(page).to have_content("Subtotal: $171.00")

      1.times {click_on "More of This!"}

      expect(page).to have_content("Quantity: 20")
      expect(page).to have_content("Subtotal: $160.00")
      expect(@item_1.item_qualifies_for_discount(20)).to eq([@discount_1, @discount_2])
      expect(@item_1.take_highest_discount(20)).to eq(@discount_2)
      expect(@item_1.calculate_discount(20)).to eq(40.0)

      expect(page).to have_content("Item Quantitiy Discount Applied!")

      click_on "Check Out"

      expect(current_path).to eq("/profile/orders")

      expect(page).to have_content("Total: $160.00")
    end
  end
end
