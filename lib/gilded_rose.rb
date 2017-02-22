def update_quality(items)
  items.each do |item|
    case item.name
      # Sulfuras has no sell-by date or decrease in quality... move on.
    when 'Sulfuras, Hand of Ragnaros'
      next

    # The quality of Aged Brie goes up as it ages.
    when 'Aged Brie'
      item.sell_in -= 1
      # The quality of an item can't be raised above 50.
      unless item.quality == 50
        item.quality += 1
      end

    # The quality of Backstage Passes goes up as it gets closer to the date
    # of the concert.
    when /^backstage passes/i
      # If the concert has already passed, the quality is set to 0.
      if item.sell_in < 0
        item.quality = 0

      # Increase quality by 3 if there are 5 days or less left.
      elsif item.sell_in <= 5
        item.quality += 3

      # Increase quality by 2 if there are 10 days or less left.
      elsif item.sell_in <= 10
        item.quality += 2

      # There are more than 10 days left, increase the quality by 1.
      else
        item.quality += 1
      end

      if item.quality > 50
        item.quality = 50
      end

      item.sell_in -= 1

    # Conjured items degrade twice as fast as normal items
    when /^conjured/i
      # Once the sell-by date has passed, quality degrades twice as fast.
      item.quality -= item.sell_in < 0 ? 4 : 2
      if item.quality < 0
        item.quality = 0
      end

      item.sell_in -= 1

    else
      # Once the sell-by date has passed, quality degrades twice as fast.
      item.quality -= item.sell_in < 0 ? 2 : 1
      if item.quality < 0
        item.quality = 0
      end

      item.sell_in -= 1
    end
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
