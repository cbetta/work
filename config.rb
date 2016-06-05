set :url_root, 'https://work.betta.io'

set :markdown_engine, :kramdown
set :markdown, :fenced_code_blocks => true, :smartypants => true

activate :search_engine_sitemap

helpers do
  def active(uri, exact = false)
    if exact
      return "active" if current_page.url == uri
    else
      return "active" if current_page.url.index(uri) == 0
    end
    nil
  end

  def description
    'Work Betta'
  end

  def title
    'Work Betta'
  end

  def image
    if current_page.data.image
      data.site.root+image_path(current_page.data.image)
    else
      data.site.root+image_path('workbetta.png')
    end
  end
end

activate :sprockets

activate :livereload
activate :directory_indexes

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'workbetta.io'
  s3_sync.region                     = 'eu-central-1'
  s3_sync.aws_access_key_id          = 'AKIAI7MLWZX43LYE2ILA'
  s3_sync.aws_secret_access_key      = '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'
end

activate :cloudfront do |cf|
  cf.access_key_id = 'AKIAI7MLWZX43LYE2ILA'
  cf.secret_access_key = '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'
  cf.distribution_id = 'E188EU800OR7PY'
end

caching_policy 'text/html', max_age: 0, must_revalidate: true
default_caching_policy max_age:(60 * 60 * 24 * 365)

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-2925354-7'
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :layout, 'default'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end
