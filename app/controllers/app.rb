# frozen_string_literal: true

require 'roda'
require 'slim'

module PaperDeep
  # Web App
  class App < Roda
    plugin :public, root: "app/views" , gzip: true
    # plugin :assets, ["app/views/static/media", "app/views/static/css", "app/views/static/js"]
    # plugin :render, engine: 'html', views: 'app/views'
    plugin :assets, js_dir:'app/views/static/js'#,css_dir:'app/views/static/css'
    # plugin :halt
    route do |routing|
    #   routing.on "static" do
        routing.public
        routing.assets
    #   end

    #   GET /
        routing.root do
        #   routing.assets
          File.read("app/views/index.html")
        # render('index')
        end

        
    end
  end
end