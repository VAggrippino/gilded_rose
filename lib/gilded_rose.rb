def update_quality(items)
  brie = 'Aged Brie'
  sulfuras = 'Sulfuras, Hand of Ragnaros'
  #pass = 'Backstage passes to a TAFKAL80ETC concert'
  pass = 'backstage passes'

  items.each do |item|
    # If the item is not brie or a pass, decrease the quality.
    if item.name != brie && item.name[0..15].downcase != pass
      # Only decrement the quality if it's higher than 0.
      if item.quality > 0
        # Only decrement the quality if it's not a sulfuras.
        if item.name != sulfuras
          item.quality -= 1
        end
      end

    # The item is brie or a pass and the quality increases.
    else
      # Only increase the quality if it's below 50.
      if item.quality < 50
        item.quality += 1

        # If there are 10 days or less left to sell the pass, increase the
        # quality by 2.
        if item.name[0..15].downcase == pass
          if item.sell_in < 11
            if item.quality < 50 # <- Should be <= 48 to accommodate an increase in quality of 2
              item.quality += 1 # <- Should be 2
            end
          end
          # If there are 5 days or less left to sell the pass, increase the
          # quality by 3
          if item.sell_in < 6
            if item.quality < 50 # <- Should be <= 47 to accommodate an increase in quality of 3
              item.quality += 1 # <- Should be 3
            end
          end
        end
      end
    end

    # Decrease the sell_in value unless the item is sulfuras.
    if item.name != sulfuras
      item.sell_in -= 1
    end

    # If there are no days left to sell the item, decrease the quality again.
    if item.sell_in < 0
      # The quality of brie goes up as it ages, so it is excluded here.
      if item.name != brie

        # The quality of a pass is decreased to 0 when the sell_in value is
        # below 0, so it is excluded here.
        if item.name[0..15].downcase != pass

          # The item is not brie or a pass, so we reduce the quality for the
          # second time.
          if item.quality > 0
            # The quality of sulfuras never changes, so we exclude it here.
            if item.name != sulfuras
              item.quality -= 1
            end
          end

        # The item is a pass and we reduce the quality to 0.
        else
          # This isn't clear. It should just be item.quality = 0.
          item.quality = item.quality - item.quality
        end

      # The item is brie. Increase the quality.
      else
        # Only increase the quality if it's less than 50.
        if item.quality < 50
          item.quality += 1
        end
      end
    end
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
