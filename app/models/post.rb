class Post < ApplicationRecord
  before_validation do
    self.slug ||= title.to_s.parameterize
  end
end
