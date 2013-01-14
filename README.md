# Sunrise CMS

Open source mini content management system for programmers.

## Instructions

### ActiveRecord
  
Create @Gemfile@ for [active_record](https://gist.github.com/4529926#file-gemfile-active_record).

```bash
$> rails g devise:install
$> rails g audited:install
$> rails g sunrise:install --orm=active_record
```

Copy db migrations files:

```bash
$> rake sunrise:install:migrations
$> rake page_parts_engine:install:migrations
$> rake meta_manager_engine:install:migrations
```

### Mongoid

Create @Gemfile@ for [mongoid](https://gist.github.com/4529926#file-gemfile-mongoid).

```bash
$> rails g sunrise:install --orm=mongoid
```

## Export data

### XML, JSON, CSV

  GET /manage/users/export.xml
  GET /manage/users/export.csv
  
### JSON

  GET /manage/users/export.json

For more info look at jbuilder https://rubygems.org/gems/jbuilder.

### Excel

  gem "ruby2xlsx", "~> 0.0.1"

  GET /manage/users/export.xlsx

## Usage

Just create class:

```ruby
class SunriseProduct < Sunrise::AbstractModel
  self.resource_name = "Product"
  
  list :thumbs do
    scope { Product.includes(:picture) }
    preview { lambda { |product| product.picture.try(:url, :thumb) } }

    field :title
    field :price
    field :total_stock
  end
  
  show do
    field :title
    field :price
    field :total_stock
    field :sort_order
    field :is_visible
  end
  
  edit do
    field :title
    field :price
    field :total_stock
    field :notes

    group :sidebar, :holder => :sidebar do
      field :sale_limit_id, :collection => lambda { SaleLimit.all }, :include_blank => false
      field :sort_order
      field :is_visible, :boolean => true
    end

    group :bottom, :holder => :bottom do
      nested_attributes :variants do
        field :size
        field :total_stock, :div_style => 'width:100%;clear:both;'
        field :item_model_id, :collection => lambda { ItemModel.all }, :include_blank => false
      end
    
      field :picture, :as => :uploader
    end
  end
end
```

Copyright (c) 2013 Fodojo, released under the MIT license
