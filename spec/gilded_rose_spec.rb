require_relative '../lib/gilded_rose'

default_sell_in = 15
default_quality = 15

item = Item.new('basic item', default_sell_in, default_quality)
expired_item = Item.new('expired item', -1, default_quality)
expired_q1_item = Item.new('expired_q1_item', -1, 1)
q0_item = Item.new('q0_item', default_sell_in, 0)
brie = Item.new('Aged Brie', default_sell_in, default_quality)
hq_brie = Item.new('Aged Brie', default_sell_in, 50)
sulfuras = Item.new('Sulfuras, Hand of Ragnaros', default_sell_in, 80)

pass = Item.new('Backstage Passes', default_sell_in, default_quality)
pass_sell_in_8 = Item.new('Backstage Passes', 8, default_quality)
pass_sell_in_3 = Item.new('Backstage Passes', 3, default_quality)
expired_pass = Item.new('Backstage Passes', -1, default_quality)
pass_hq_soon = Item.new('Backstage Passes', 3, 50)

conjured = Item.new('Conjured', default_sell_in, default_quality)
expired_conjured = Item.new('Conjured', -1, default_quality)
conjured_q1 = Item.new('Conjured', default_sell_in, 1)
expired_conjured_q3 = Item.new('Conjured', -1, 3)


describe "#update_quality" do
  context "Given a basic item" do
    before { update_quality([item]) }

    it "reduces the item's sell_in and quality values." do
      expect(item).to have_attributes(:sell_in => default_sell_in - 1, :quality => default_quality - 1)
    end
  end

  # Basic items
  context "Given an expired basic item" do
    before { update_quality([expired_item]) }

    it "reduces the sell_in value by 1 and the quality value by 2." do
      expect(expired_item).to have_attributes(:sell_in => -2, :quality => default_quality - 2)
    end
  end

  context "Given an item which already has a quality of 0 or 1" do
    items = [q0_item, expired_q1_item]
    before { update_quality(items) }

    it "never reduces the quality below 0." do
      expect(q0_item).to have_attributes(:sell_in => default_sell_in - 1, :quality => 0)
      expect(expired_q1_item).to have_attributes(:sell_in => -2, :quality => 0)
    end
  end

  # Aged Brie
  context "Given 'Aged Brie'" do
    before { update_quality([brie]) }

    it "increases the quality of the item" do
      expect(brie).to have_attributes(:sell_in => default_sell_in - 1, :quality => default_quality + 1)
    end
  end

  context "Given 'Aged Brie' with a quality of 50" do
    before { update_quality([hq_brie]) }

    it "does not increase the quality beyond 50" do
      expect(hq_brie).to have_attributes(:sell_in => default_sell_in - 1, :quality => 50)
    end
  end

  # Sulfuras
  context "Given 'Sulfuras'" do
    before { update_quality([sulfuras]) }

    it "ignores the sell_in and quality values" do
      expect(sulfuras).to have_attributes(:sell_in => default_sell_in, :quality => 80)
    end
  end

  # Backstage Passes
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
      expect(expired_pass).to have_attributes(:sell_in => -2, :quality => 0)
    end
  end

  context "Given a 'Backstage Passes' with a low sell_in and high quality" do
    before { update_quality([pass_hq_soon]) }

    it "only increases the quality to 50" do
      expect(pass_hq_soon).to have_attributes(:sell_in => 2, :quality => 50)
    end
  end

  # Conjured
  context "Given a 'Conjured' item" do
    before { update_quality([conjured]) }

    it "decreases the quality by 2" do
      expect(conjured).to have_attributes(:sell_in => default_sell_in - 1, :quality => default_quality - 2)
    end
  end

  context "Given a 'Conjured' item with a sell_in < 0" do
    before { update_quality([expired_conjured]) }

    it "decreases the quality by 4" do
      expect(expired_conjured).to have_attributes(:sell_in => -2, :quality => default_quality - 4)
    end
  end

  context "Given a 'Conjured' item with a quality < 2" do
    before { update_quality([conjured_q1]) }

    it "reduces the quality to 0" do
      expect(conjured_q1).to have_attributes(:sell_in => default_sell_in - 1, :quality => 0)
    end
  end

  context "Given a 'Conjured' item with a sell_in < 0 and a quality < 4" do
    before { update_quality([expired_conjured_q3]) }

    it "reduces the quality to 0" do
      expect(expired_conjured_q3).to have_attributes(:sell_in => -2, :quality => 0)
    end
  end
end
