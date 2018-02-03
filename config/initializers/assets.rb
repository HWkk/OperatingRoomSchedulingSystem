# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( jquery-ui.css )

Rails.application.config.assets.precompile += %w( mainstructure.css )

Rails.application.config.assets.precompile += %w( maincontent.css )
Rails.application.config.assets.precompile += %w( theme.css )
Rails.application.config.assets.precompile += %w( jquery-ui-timepicker-addon.css )
Rails.application.config.assets.precompile += %w( fullcalendar.css )
Rails.application.config.assets.precompile += %w( fullcalendar.print.css )
Rails.application.config.assets.precompile += %w( jquery-1.8.2.min.js )
Rails.application.config.assets.precompile += %w( jquery-ui-timepicker-addon.js )
Rails.application.config.assets.precompile += %w( jquery-ui-sliderAccess.js )
Rails.application.config.assets.precompile += %w( datepicker-zh.js )
Rails.application.config.assets.precompile += %w( fullcalendar.js )
Rails.application.config.assets.precompile += %w( jquery-ui.min1.9.1.js )


Rails.application.config.assets.precompile += %w( jquery.js )
Rails.application.config.assets.precompile += %w( jquery-1.8.3.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( jquery.dcjqaccordion.2.7.js )
Rails.application.config.assets.precompile += %w( jquery.scrollTo.min.js )
Rails.application.config.assets.precompile += %w( jquery.nicescroll.js )
Rails.application.config.assets.precompile += %w( jquery.sparkline.js )
Rails.application.config.assets.precompile += %w( common-scripts.js )
Rails.application.config.assets.precompile += %w( jquery.gritter.js )
Rails.application.config.assets.precompile += %w( gritter-conf.js )
Rails.application.config.assets.precompile += %w( sparkline-chart.js )
Rails.application.config.assets.precompile += %w( zabuto_calendar.js )



Rails.application.config.assets.precompile += %w( style.css )

Rails.application.config.assets.precompile += %w( style-responsive.css)

Rails.application.config.assets.precompile += %w( bootstrap.css )

