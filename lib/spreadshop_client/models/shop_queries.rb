module SpreadshopClient
  module Models
    module ShopQueries
      GET_SHOP = <<~GQL.strip
        query($name: String!, $platform: Platform!, $locale: Locale!) {
            shop(name: $name, platform: $platform, locale: $locale) {
                id
                name
            }
        }
      GQL
    end
  end
end
