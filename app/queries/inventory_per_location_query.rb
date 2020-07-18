 class InventoryPerLocationQuery < BaseTimeFilteredQuery
   def function
     :count
   end

   def search_field
     :created_at
   end

   def relation
     InventoryTally.joins(:storage_location).group("locations.id")
   end
 end
