class Structure < ActiveRecord::Base
  include Sunrise::Models::Structure
  include PageParts::Extension
  include MetaManager::Taggable
  include PublicActivity::Model

  tracked owner: ->(controller, model) { controller.try(:current_user) }
  page_parts :content
end
