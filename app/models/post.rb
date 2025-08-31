class Post < ApplicationRecord
  validates :title, :slug, :body_md, :status, presence: true

  before_validation do
    self.slug = title.to_s.parameterize if self.slug.blank?
    self.status = "draft" if self.status.blank?
  end
end
