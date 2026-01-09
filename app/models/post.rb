class Post < ApplicationRecord
  validates :title, :slug, :body_md, :status, presence: true

  scope :published, -> {
    where(status: "published")
      .where("published_at IS NULL OR published_at <= ?", Time.current)
  }

  before_validation do
    self.slug = title.to_s.parameterize if self.slug.blank?
    self.status = "draft" if self.status.blank?
  end
end
