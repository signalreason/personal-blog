class Post < ApplicationRecord
  before_save do
    self.body_html = Commonmarker.to_html(body_md || "")
  end
  before_validation do
    self.slug ||= title.to_s.parameterize
  end
end
