def get_presto_version
  "0.182"
end

def get_redshift_jdbc_driver_version
  "42-1.2.10.1009"
end

def datagrip_settings_location
  settings_location = Dir[File.join("/Users/#{ENV['USER']}", '/Library/Preferences', 'DataGrip*')].sort.last
  raise "DataGrip Settings folder does not exist." unless settings_location and Dir.exist? settings_location
  settings_location
end
