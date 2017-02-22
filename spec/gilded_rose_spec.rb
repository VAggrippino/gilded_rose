require_relative '../lib/gilded_rose'

item = Item.new('basic item', 5, 10)
expired_item = Item.new('expired item', 0, 10)
expired_q1_item = Item.new('expired_q1_item', 0, 1)
q0_item = Item.new('q0_item', 5, 0)
brie = Item.new('Aged Brie', 5, 10)
pass = Item.new('Backstage Passes', 5, 10)

describe "#update_quality" do
  context "Given a basic item" do
    before { update_quality([item]) }

    it "reduces the item's sell_in and quality values" do
      expect(item).to have_attributes(:sell_in => 4, :quality => 9)
    end
  end

  context "Given an expired basic item" do
    before { update_quality([expired_item]) }

    it "reduces the sell_in value by 1 and the quality value by 2" do
      expect(expired_item).to have_attributes(:sell_in => -1, :quality => 8)
    end
  end

  context "Given an item which already has a quality of 0 or 1" do
    before do
      update_quality([expired_q1_item])
      update_quality([q0_item])
    end

    it "never reduces the quality to a negative value." do
      expect(expired_q1_item).to have_attributes(:sell_in => -1, :quality => 0)
      expect(q0_item).to have_attributes(:sell_in => 4, :quality => 0)
    end
  end

  context "Given 'Aged Brie'" do
    before { update_quality([brie]) }

    it "increases the quality of the item" do
      expect(brie).to have_attributes(:sell_in => 4, :quality => 11)
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
