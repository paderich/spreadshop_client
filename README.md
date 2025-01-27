# SpreadshopClient

[![Gem Version](https://badge.fury.io/rb/spreadshop_client.svg?icon=si%3Arubygems)](https://badge.fury.io/rb/spreadshop_client)
[![Build Status](https://github.com/paderich/spreadshop_client/actions/workflows/main.yml/badge.svg)](https://github.com/paderich/spreadshop_client/actions)

`SpreadshopClient` is a Ruby gem that provides a convenient interface for interacting with the Spreadshop GraphQL API. It simplifies fetching shop data by encapsulating the necessary queries and handling the API communication, making it easy to integrate into your Ruby projects or Rails applications.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'spreadshop_client'
```

And then execute:
```ruby
bundle install
```

Or install it yourself as:
```ruby
gem install spreadshop_client
```
## Usage

### Fetch Shop
Here's an example of how to use the SpreadshopClient gem to fetch shop details:
```ruby
require 'spreadshop_client'

name = "my-shop"       # Replace with the actual shop name
platform = "EU"           # Replace with the platform
locale = "de_DE"          # Replace with the locale

response = SpreadshopClient.get_shop(name: name, platform: platform, locale: locale)

if response.is_a?(SpreadshopClient::Shop)
  puts "Shop ID: #{response.id}"
  puts "Shop Name: #{response.name}"
elsif response.is_a?(Hash) && response[:error]
  puts "Error: #{response[:error]}"
else
  puts "Unexpected response: #{response.inspect}"
end
```

### Fetching Products
To fetch all products from a shop, you can use the SpreadshopClient as follows:
```ruby
require 'spreadshop_client'

shop_id = "1394271"       # Replace with the actual shop ID
platform = "EU"           # Replace with the platform
locale = "de_DE"          # Replace with the locale

products = SpreadshopClient::Product.get_all(shop_id: shop_id, platform: platform, locale: locale)

if products.is_a?(Array)
  puts "Number of Products: #{products.size}"
  
  first_product = products.first
  puts "First Product ID: #{first_product.id}"
  puts "First Product Name: #{first_product.name}"
else
  puts "Error fetching products: #{products[:error]}"
end
```

To fetch a specific product by ID:
```ruby
product_id = "12345"  # Replace with the actual product ID

product = SpreadshopClient::Product.get_by_id(product_id: product_id, shop_id: shop_id, platform: platform, locale: locale)

if product.is_a?(SpreadshopClient::Product)
  puts "Product ID: #{product.id}"
  puts "Product Name: #{product.name}"
else
  puts "Error fetching product by ID: #{product[:error]}"
end
```


## Development and Testing
### Run Tests:
```ruby
rake test
```

### Check Code Style:

The project uses StandardRB to ensure consistent coding style. Run the linter with:
```ruby
rake standard
```
### Run StandardRB Auto-Fix:
```ruby
rake standard:fix
```




## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/paderich/spreadshop_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the code of conduct.

## License
The gem is available as open source under the terms of the MIT License.

## Code of Conduct
Everyone interacting in the SpreadshopClient project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the code of conduct.