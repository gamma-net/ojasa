# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( css/login.css css/login4.css layout/css/custom.css css/inbox.css layout/css/login.css layout/css/themes/darkblue.css )
Rails.application.config.assets.precompile += %w( css/profile.css css/profile.css css/tasks.css layout/css/layout.css css/todo.css layout/css/themes/darkblue.css layout/css/custom.css )
Rails.application.config.assets.precompile += %w( bower_components/bootstrap/dist/css/bootstrap.min.css bower_components/metisMenu/dist/metisMenu.min.css dist/css/timeline.css dist/css/sb-admin-2 bower_components/morrisjs/morris.css bower_components/font-awesome/css/font-awesome.min.css styles.css )
Rails.application.config.assets.precompile += %w( js/jquery.js js/plugins.js js/bootstrap-datepicker.js )
Rails.application.config.assets.precompile += %w( css/bootstrap.css style.css css/dark.css css/font-icons.css css/animate.css css/magnific-popup.css css/responsive.css css/datepicker.css)
Rails.application.config.assets.precompile += %w( js/autocomplete-maps.js js/functions.js )
Rails.application.config.assets.precompile += %w( images/logo.png images/logo@2x.png )
Rails.application.config.assets.precompile += %w( bower_components/jquery/dist/jquery.min.js bower_components/bootstrap/dist/js/bootstrap.min.js bower_components/metisMenu/dist/metisMenu.min.js bower_components/raphael/raphael-min.js bower_components/morrisjs/morris.min.js js/morris-data.js dist/js/sb-admin-2.js )
Rails.application.config.assets.precompile += %w( scripts/components-pickers.js scripts/components-form-tools2.js layout/scripts/layout.js layout/scripts/demo.js scripts/login.js scripts/contact-us.js )
Rails.application.config.assets.precompile += %w( scripts/todo.js layout/scripts/quick-sidebar.js scripts/inbox.js scripts/lock.js scripts/profile.js scripts/form-fileupload.js )

Rails.application.config.assets.precompile += %w( images/logo.png images/logo@2x.png images/services_lock.jpg images/services_homeimprovement.jpg )

Rails.application.config.assets.precompile += %w( images/services_1.jpg images/services_2.jpg images/services_3.jpg images/services_4.jpg images/services_5.jpg images/services_6.jpg images/services_beauty.jpg images/bghome.jpg )
Rails.application.config.assets.precompile += %w( images/cc.png images/banktransfer.png images/bglogin.jpg )
Rails.application.config.assets.precompile += %w( layout/img/loading.gif layout/img/avatar.png layout/img/avatar1.jpg layout/img/avatar2.jpg layout/img/avatar3.jpg )
