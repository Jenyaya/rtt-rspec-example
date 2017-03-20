require 'rspec/core/rake_task'
require './helpers/helpers.rb'

namespace :rtt do

  namespace :ci do

    desc 'Run smoke tests for UserManagementServiceApi'
    RSpec::Core::RakeTask.new(:user_permissions, [:env, :log_level]) do |task, args|

      save_environment_to_config(environment: args[:env])

      task.pattern = 'spec/api/rest/avid.social/smoke/**{,/*/**}/*_spec.rb'
      task.rspec_opts = rake_report_to_html('avid_social_smoke', 'latest')
    end

  end


end