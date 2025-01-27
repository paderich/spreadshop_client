module SpreadshopClient
  module Models
    module ProductsQueries
      GET_PRODUCTS = <<~GQL.strip
        query($shopId: ID!, $platform: Platform!, $locale: Locale!) {
          products(shopId: $shopId, platform: $platform, locale: $locale) {
            items {
              id
              name
              image {
                src
                srcset
                altText
                format
              }
              price {
                vatExcluded
                vatIncluded
                vatAmount
              }
            }
          }
        }
      GQL
    end
  end
end
