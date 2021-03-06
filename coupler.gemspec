# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "coupler"
  s.version = "0.0.9"
  s.platform = "java"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeremy Stephens"]
  s.date = "2012-03-01"
  s.description = "Coupler is a (JRuby) desktop application designed to link datasets together"
  s.email = "jeremy.f.stephens@vanderbilt.edu"
  s.executables = ["coupler"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    ".document",
    ".gitmodules",
    ".rbenv-version",
    ".rvmrc",
    ".vimrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "NOTES",
    "README.rdoc",
    "Rakefile",
    "TODO",
    "VERSION",
    "bin/coupler",
    "coupler.gemspec",
    "db/.gitignore",
    "db/migrate/001_initial_schema.rb",
    "db/migrate/002_stub.rb",
    "db/migrate/003_stub.rb",
    "db/migrate/004_create_comparisons.rb",
    "db/migrate/005_move_database_name.rb",
    "db/migrate/006_upgrade_comparisons.rb",
    "db/migrate/007_add_which_to_comparisons.rb",
    "db/migrate/008_add_result_field_to_transformations.rb",
    "db/migrate/009_add_generated_flag_to_fields.rb",
    "db/migrate/010_create_imports.rb",
    "db/migrate/011_add_primary_key_type.rb",
    "db/migrate/012_add_transformed_with_to_resources.rb",
    "db/migrate/013_add_run_count_to_scenarios.rb",
    "db/migrate/014_add_last_accessed_at_to_some_tables.rb",
    "db/migrate/015_add_run_number_to_results.rb",
    "db/migrate/016_fix_scenario_run_count.rb",
    "db/migrate/017_rename_comparison_columns.rb",
    "db/migrate/018_stub.rb",
    "db/migrate/019_add_columns_to_imports.rb",
    "db/migrate/020_rename_import_columns.rb",
    "db/migrate/021_add_fields_to_connections.rb",
    "db/migrate/022_remove_database_name_from_resources.rb",
    "db/migrate/023_add_import_jobs.rb",
    "db/migrate/024_add_error_msg_to_jobs.rb",
    "db/migrate/025_add_notifications.rb",
    "db/migrate/026_add_status_to_resources.rb",
    "db/migrate/027_add_notification_id_to_jobs.rb",
    "features/connections.feature",
    "features/matchers.feature",
    "features/projects.feature",
    "features/resources.feature",
    "features/scenarios.feature",
    "features/step_definitions/coupler_steps.rb",
    "features/step_definitions/matchers_steps.rb",
    "features/step_definitions/resources_steps.rb",
    "features/step_definitions/scenarios_steps.rb",
    "features/step_definitions/transformations_steps.rb",
    "features/support/env.rb",
    "features/transformations.feature",
    "features/wizard.feature",
    "gfx/coupler-header.svg",
    "gfx/coupler-sidebar.svg",
    "gfx/coupler.svg",
    "gfx/icon.svg",
    "lib/coupler.rb",
    "lib/coupler/base.rb",
    "lib/coupler/data_uploader.rb",
    "lib/coupler/database.rb",
    "lib/coupler/extensions.rb",
    "lib/coupler/extensions/connections.rb",
    "lib/coupler/extensions/exceptions.rb",
    "lib/coupler/extensions/imports.rb",
    "lib/coupler/extensions/jobs.rb",
    "lib/coupler/extensions/matchers.rb",
    "lib/coupler/extensions/notifications.rb",
    "lib/coupler/extensions/projects.rb",
    "lib/coupler/extensions/resources.rb",
    "lib/coupler/extensions/results.rb",
    "lib/coupler/extensions/scenarios.rb",
    "lib/coupler/extensions/transformations.rb",
    "lib/coupler/extensions/transformers.rb",
    "lib/coupler/helpers.rb",
    "lib/coupler/import_buffer.rb",
    "lib/coupler/logger.rb",
    "lib/coupler/models.rb",
    "lib/coupler/models/common_model.rb",
    "lib/coupler/models/comparison.rb",
    "lib/coupler/models/connection.rb",
    "lib/coupler/models/field.rb",
    "lib/coupler/models/import.rb",
    "lib/coupler/models/job.rb",
    "lib/coupler/models/jobify.rb",
    "lib/coupler/models/matcher.rb",
    "lib/coupler/models/notification.rb",
    "lib/coupler/models/project.rb",
    "lib/coupler/models/resource.rb",
    "lib/coupler/models/result.rb",
    "lib/coupler/models/scenario.rb",
    "lib/coupler/models/scenario/runner.rb",
    "lib/coupler/models/transformation.rb",
    "lib/coupler/models/transformer.rb",
    "lib/coupler/models/transformer/runner.rb",
    "lib/coupler/runner.rb",
    "lib/coupler/scheduler.rb",
    "log/.gitignore",
    "misc/README",
    "misc/jruby-json.license",
    "misc/rack-flash.license",
    "script/dbconsole.rb",
    "tasks/annotations.rake",
    "tasks/db.rake",
    "tasks/environment.rake",
    "tasks/jeweler.rake",
    "tasks/package.rake",
    "tasks/rdoc.rake",
    "tasks/test.rake",
    "tasks/vendor.rake",
    "test/README.txt",
    "test/config.yml",
    "test/fixtures/duplicate-keys.csv",
    "test/fixtures/no-headers.csv",
    "test/fixtures/people.csv",
    "test/fixtures/varying-row-size.csv",
    "test/functional/test_base.rb",
    "test/functional/test_connections.rb",
    "test/functional/test_imports.rb",
    "test/functional/test_jobs.rb",
    "test/functional/test_matchers.rb",
    "test/functional/test_notifications.rb",
    "test/functional/test_projects.rb",
    "test/functional/test_resources.rb",
    "test/functional/test_results.rb",
    "test/functional/test_scenarios.rb",
    "test/functional/test_transformations.rb",
    "test/functional/test_transformers.rb",
    "test/helper.rb",
    "test/integration/test_field.rb",
    "test/integration/test_import.rb",
    "test/integration/test_running_scenarios.rb",
    "test/integration/test_transformation.rb",
    "test/integration/test_transforming.rb",
    "test/table_sets.rb",
    "test/unit/models/test_common_model.rb",
    "test/unit/models/test_comparison.rb",
    "test/unit/models/test_connection.rb",
    "test/unit/models/test_field.rb",
    "test/unit/models/test_import.rb",
    "test/unit/models/test_job.rb",
    "test/unit/models/test_matcher.rb",
    "test/unit/models/test_notification.rb",
    "test/unit/models/test_project.rb",
    "test/unit/models/test_resource.rb",
    "test/unit/models/test_result.rb",
    "test/unit/models/test_scenario.rb",
    "test/unit/models/test_transformation.rb",
    "test/unit/models/test_transformer.rb",
    "test/unit/test_base.rb",
    "test/unit/test_coupler.rb",
    "test/unit/test_data_uploader.rb",
    "test/unit/test_database.rb",
    "test/unit/test_helpers.rb",
    "test/unit/test_import_buffer.rb",
    "test/unit/test_logger.rb",
    "test/unit/test_runner.rb",
    "test/unit/test_scheduler.rb",
    "uploads/.gitignore",
    "webroot/public/css/960.css",
    "webroot/public/css/dataTables.css",
    "webroot/public/css/jquery-ui.css",
    "webroot/public/css/jquery.treeview.css",
    "webroot/public/css/reset.css",
    "webroot/public/css/style.css",
    "webroot/public/css/text.css",
    "webroot/public/favicon.ico",
    "webroot/public/images/12_col.gif",
    "webroot/public/images/16_col.gif",
    "webroot/public/images/add.png",
    "webroot/public/images/ajax-loader.gif",
    "webroot/public/images/cog.png",
    "webroot/public/images/coupler.png",
    "webroot/public/images/foo.png",
    "webroot/public/images/hammer.png",
    "webroot/public/images/header.png",
    "webroot/public/images/home.gif",
    "webroot/public/images/jobs.gif",
    "webroot/public/images/sidebar-bottom.png",
    "webroot/public/images/sidebar.png",
    "webroot/public/images/treeview-default-line.gif",
    "webroot/public/images/treeview-default.gif",
    "webroot/public/images/ui-anim_basic_16x16.gif",
    "webroot/public/images/ui-bg_flat_0_aaaaaa_40x100.png",
    "webroot/public/images/ui-bg_flat_75_ffffff_40x100.png",
    "webroot/public/images/ui-bg_glass_55_fbf9ee_1x400.png",
    "webroot/public/images/ui-bg_glass_65_ffffff_1x400.png",
    "webroot/public/images/ui-bg_glass_75_dadada_1x400.png",
    "webroot/public/images/ui-bg_glass_75_e6e6e6_1x400.png",
    "webroot/public/images/ui-bg_glass_95_fef1ec_1x400.png",
    "webroot/public/images/ui-bg_highlight-hard_30_565356_1x100.png",
    "webroot/public/images/ui-bg_highlight-hard_75_888588_1x100.png",
    "webroot/public/images/ui-bg_highlight-soft_30_6e3b3a_1x100.png",
    "webroot/public/images/ui-bg_highlight-soft_35_8e8b8e_1x100.png",
    "webroot/public/images/ui-bg_highlight-soft_75_cccccc_1x100.png",
    "webroot/public/images/ui-icons_222222_256x240.png",
    "webroot/public/images/ui-icons_2e83ff_256x240.png",
    "webroot/public/images/ui-icons_454545_256x240.png",
    "webroot/public/images/ui-icons_888888_256x240.png",
    "webroot/public/images/ui-icons_cd0a0a_256x240.png",
    "webroot/public/images/ui-icons_ffffff_256x240.png",
    "webroot/public/js/ajaxupload.js",
    "webroot/public/js/application.js",
    "webroot/public/js/jquery-ui.combobox.js",
    "webroot/public/js/jquery-ui.js",
    "webroot/public/js/jquery-ui.min.js",
    "webroot/public/js/jquery.dataTables.min.js",
    "webroot/public/js/jquery.min.js",
    "webroot/public/js/jquery.timeago.js",
    "webroot/public/js/jquery.tooltip.min.js",
    "webroot/public/js/jquery.treeview.min.js",
    "webroot/public/js/resource.js",
    "webroot/public/js/results.js",
    "webroot/public/js/transformations.js",
    "webroot/views/connections/index.erb",
    "webroot/views/connections/list.erb",
    "webroot/views/connections/new.erb",
    "webroot/views/connections/show.erb",
    "webroot/views/imports/edit.erb",
    "webroot/views/imports/form.erb",
    "webroot/views/imports/new.erb",
    "webroot/views/index.erb",
    "webroot/views/jobs/index.erb",
    "webroot/views/jobs/list.erb",
    "webroot/views/layout.erb",
    "webroot/views/matchers/form.erb",
    "webroot/views/matchers/list.erb",
    "webroot/views/notifications/index.erb",
    "webroot/views/projects/form.erb",
    "webroot/views/projects/index.erb",
    "webroot/views/projects/show.erb",
    "webroot/views/resources/edit.erb",
    "webroot/views/resources/index.erb",
    "webroot/views/resources/list.erb",
    "webroot/views/resources/new.erb",
    "webroot/views/resources/show.erb",
    "webroot/views/resources/transform.erb",
    "webroot/views/results/csv.erb",
    "webroot/views/results/details.erb",
    "webroot/views/results/index.erb",
    "webroot/views/results/list.erb",
    "webroot/views/results/record.erb",
    "webroot/views/results/show.erb",
    "webroot/views/scenarios/index.erb",
    "webroot/views/scenarios/list.erb",
    "webroot/views/scenarios/new.erb",
    "webroot/views/scenarios/run.erb",
    "webroot/views/scenarios/show.erb",
    "webroot/views/sidebar.erb",
    "webroot/views/transformations/create.erb",
    "webroot/views/transformations/for.erb",
    "webroot/views/transformations/index.erb",
    "webroot/views/transformations/list.erb",
    "webroot/views/transformations/new.erb",
    "webroot/views/transformations/preview.erb",
    "webroot/views/transformers/edit.erb",
    "webroot/views/transformers/form.erb",
    "webroot/views/transformers/index.erb",
    "webroot/views/transformers/list.erb",
    "webroot/views/transformers/new.erb",
    "webroot/views/transformers/preview.erb",
    "webroot/views/transformers/show.erb"
  ]
  s.homepage = "http://github.com/coupler/coupler"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Coupler is a desktop application for linking datasets together"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, ["= 1.3.6"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<sequel>, [">= 0"])
      s.add_runtime_dependency(%q<rack-flash>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<fastercsv>, [">= 0"])
      s.add_runtime_dependency(%q<carrierwave-sequel>, [">= 0"])
      s.add_runtime_dependency(%q<mongrel>, [">= 0"])
      s.add_runtime_dependency(%q<jdbc-mysql>, [">= 0"])
      s.add_runtime_dependency(%q<jdbc-h2>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<forgery>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, ["= 2.2.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
      s.add_development_dependency(%q<git>, [">= 0"])
      s.add_development_dependency(%q<thor>, [">= 0"])
      s.add_development_dependency(%q<table_maker>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 0"])
      s.add_development_dependency(%q<jruby-openssl>, [">= 0"])
    else
      s.add_dependency(%q<rack>, ["= 1.3.6"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<sequel>, [">= 0"])
      s.add_dependency(%q<rack-flash>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<fastercsv>, [">= 0"])
      s.add_dependency(%q<carrierwave-sequel>, [">= 0"])
      s.add_dependency(%q<mongrel>, [">= 0"])
      s.add_dependency(%q<jdbc-mysql>, [">= 0"])
      s.add_dependency(%q<jdbc-h2>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<forgery>, [">= 0"])
      s.add_dependency(%q<test-unit>, ["= 2.2.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<timecop>, [">= 0"])
      s.add_dependency(%q<git>, [">= 0"])
      s.add_dependency(%q<thor>, [">= 0"])
      s.add_dependency(%q<table_maker>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 0"])
      s.add_dependency(%q<jruby-openssl>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>, ["= 1.3.6"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<sequel>, [">= 0"])
    s.add_dependency(%q<rack-flash>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<fastercsv>, [">= 0"])
    s.add_dependency(%q<carrierwave-sequel>, [">= 0"])
    s.add_dependency(%q<mongrel>, [">= 0"])
    s.add_dependency(%q<jdbc-mysql>, [">= 0"])
    s.add_dependency(%q<jdbc-h2>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<forgery>, [">= 0"])
    s.add_dependency(%q<test-unit>, ["= 2.2.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<timecop>, [">= 0"])
    s.add_dependency(%q<git>, [">= 0"])
    s.add_dependency(%q<thor>, [">= 0"])
    s.add_dependency(%q<table_maker>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 0"])
    s.add_dependency(%q<jruby-openssl>, [">= 0"])
  end
end

