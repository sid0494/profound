# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( bootstrap.min.css )
Rails.application.config.assets.precompile += %w( sb-admin.css )
Rails.application.config.assets.precompile += %w( morris.css )
Rails.application.config.assets.precompile += %w( font-awesome.min.css )

Rails.application.config.assets.precompile += %w( ionicons.min.css )
Rails.application.config.assets.precompile += %w( AdminLTE.min.css )
Rails.application.config.assets.precompile += %w( skin-blue.min.css )
Rails.application.config.assets.precompile += %w( green.css ) 
Rails.application.config.assets.precompile += %w( jquery-jvectormap-1.2.2.css )

Rails.application.config.assets.precompile += %w( jquery.js )
Rails.application.config.assets.precompile += %w( bootstrap.js )  

Rails.application.config.assets.precompile += %w( bootstrap3-wysihtml5.all.min.js )
Rails.application.config.assets.precompile += %w( jquery.slimscroll.min.js )
Rails.application.config.assets.precompile += %w( fastclick.min.js )
Rails.application.config.assets.precompile += %w( app.min.js )
Rails.application.config.assets.precompile += %w( dashboard.js )
Rails.application.config.assets.precompile += %w( demo.js )
Rails.application.config.assets.precompile += %w( icheck.min.js )
Rails.application.config.assets.precompile += %w( jquery.knob.js )
Rails.application.config.assets.precompile += %w( jquery-jvectormap-1.2.2.min.js )
Rails.application.config.assets.precompile += %w( jquery-jvectormap-world-mill-en.js ) 
Rails.application.config.assets.precompile += %w( jquery.sparkline.min.js )
Rails.application.config.assets.precompile += %w( jQuery-2.1.3.min.js )
Rails.application.config.assets.precompile += %w( jquery-ui.js )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
