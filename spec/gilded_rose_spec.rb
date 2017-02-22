require_relative '../lib/gilded_rose'

item = Item.new('basic item', 5, 10)

describe "#update_quality" do
  context "Given a basic item" do
    before { update_quality([item]) }

    it "reduces the item's sell_in and quality values" do
      expect(item).to have_attributes(:sell_in => 4, :quality => 9)
    end
  end

  # context "with a single item" do
  #   let(:initial_sell_in) { 5 }
  #   let(:initial_quality) { 10 }
  #   let(:name) { "item" }
  #   let(:item) { Item.new(name, initial_sell_in, initial_quality) }

  #   before { update_quality([item]) }

  #   it "your specs here" do
  #     pending
  #   end
  # end

  # context "with multiple items" do
  #   let(:items) {
  #     [
  #       Item.new("NORMAL ITEM", 5, 10),
  #       Item.new("Aged Brie", 3, 10),
  #     ]
  #   }

  #   before { update_quality(items) }

  #   it "your specs here" do
  #     pending
  #   end
  # end
end
