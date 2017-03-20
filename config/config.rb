require 'yaml'
$environment_name = YAML.load_file('./config/set_env.yaml')['environment']
$environment_common = YAML.load_file('./config/environments/common.yaml')
$environment = YAML.load_file("./config/environments/#{$environment_name}_env.yaml")
