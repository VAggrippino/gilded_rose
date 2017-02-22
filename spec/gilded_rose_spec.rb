require_relative '../lib/gilded_rose'

default_sell_in = 15
default_quality = 15

item = Item.new('basic item', default_sell_in, default_quality)
expired_item = Item.new('expired item', 0, default_quality)
expired_q1_item = Item.new('expired_q1_item', 0, 1)
q0_item = Item.new('q0_item', default_sell_in, 0)
brie = Item.new('Aged Brie', default_sell_in, default_quality)
hq_brie = Item.new('Aged Brie', default_sell_in, 50)
sulfuras = Item.new('Sulfuras, Hand of Ragnaros', default_sell_in, 80)

pass = Item.new('Backstage Passes', default_sell_in, default_quality)
pass_sell_in_8 = Item.new('Backstage Passes', 8, default_quality)
pass_sell_in_3 = Item.new('Backstage Passes', 3, default_quality)
expired_pass = Item.new('Backstage Passes', 0, default_quality);

describe "#update_quality" do
  context "Given a basic item" do
    before { update_quality([item]) }

    it "reduces the item's sell_in and quality values" do
      expect(item).to have_attributes(:sell_in => default_sell_in - 1, :quality => default_quality - 1)
    end
  end

  context "Given an expired basic item" do
    before { update_quality([expired_item]) }

    it "reduces the sell_in value by 1 and the quality value by 2" do
      expect(expired_item).to have_attributes(:sell_in => -1, :quality => default_quality - 2)
    end
  end

  context "Given an item which already has a quality of 0 or 1" do
    before do
      update_quality([q0_item])
      update_quality([expired_q1_item])
    end

    it "never reduces the quality to a negative value." do
      expect(q0_item).to have_attributes(:sell_in => default_sell_in - 1, :quality => 0)
      expect(expired_q1_item).to have_attributes(:sell_in => -1, :quality => 0)
    end
  end

  context "Given 'Aged Brie'" do
    before { update_quality([brie]) }

    it "increases the quality of the item" do
      expect(brie).to have_attributes(:sell_in => default_sell_in - 1, :quality => default_quality + 1)
    end
  end

  context "Given a rare item with a quality value of 50" do
    before { update_quality([hq_brie]) }

    it "does not increase the quality value" do
      expect(hq_brie).to have_attributes(:sell_in => default_sell_in - 1, :quality => 50)
    end
  end

  context "Given 'Sulfuras'" do
    before { update_quality([sulfuras]) }

    it "ignores the sell_in and quality values" do
      expect(sulfuras).to have_attributes(:sell_in => default_sell_in, :quality => 80)
    end
  end

  context "Given 'Backstage Passes'" do
    before { update_quality([pass]) }

    it "increases the quality of the item" do
      expect(pass).to have_attributes(:sell_in => default_sell_in - 1, :quality => default_quality + 1)
    end
  end

  context "Given a 'Backstage Passes' with a sell_in <= 10" do
    before { update_quality([pass_sell_in_8]) }

    it "increases the quality by 2" do
      expect(pass_sell_in_8).to have_attributes(:sell_in => 7, :quality => default_quality + 2)
    end
  end

  context "Given a 'Backstage Passes' with a sell_in <= 5" do
    before { update_quality([pass_sell_in_3]) }

    it "increases the quality by 3" do
      expect(pass_sell_in_3).to have_attributes(:sell_in => 2, :quality => default_quality + 3)
    end
  end

  context "Given a 'Backstage Passes' with a sell_in <= 0" do
    before { update_quality([expired_pass]) }

    it "reduces the quality to 0" do
      expect(expired_pass).to have_attributes(:sell_in => -1, :quality => 0)
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
