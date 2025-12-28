json.extract! post, :id, :title, :slug, :body_md, :body_html, :summary, :status, :published_at, :created_at, :updated_at
json.url post_url(post, format: :json)
