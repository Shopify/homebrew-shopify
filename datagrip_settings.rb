require 'erb'
require_relative 'data-warehouse'

class DatagripSettings < Formula
  desc "DataGrip Settings to easily connect to the data warehouse"
  url "https://s3.amazonaws.com/shopify-data-downloads/datagrip_settings.txt"
  sha256 "afd7386c961137729bada16b7dce6303575f30beaad52a17e8699426c3b94822"
  homepage "https://vault.shopify.com/data/SQL-Client-Setup"
  version "1.0"

  @@template_folder = '/usr/local/Homebrew/Library/Taps/shopify/homebrew-shopify/templates/datagrip_settings/'

  depends_on "presto-jdbc" => :recommended
  depends_on "redshift-jdbc" => :recommended

  def install
    raise 'Please install DataGrip first.' unless is_datagrip_installed?

    template_function_mapping = {
      "databaseDrivers.xml.erb" => "update_database_drivers_settings",
      "dataSources.xml.erb" => "update_datasources_settings"
    }

    template_paths = Dir[File.join(@@template_folder, 'data*')]

    template_paths.each do |template_path|
      template_filename = File.basename(template_path)
      function = template_function_mapping[template_filename]
      self.public_send(function, template_path, template_filename)
    end
  end

  def load_template_settings(template)
    b = binding
    b.local_variable_set(:presto_version, get_presto_version)
    b.local_variable_set(:redshift_jdbc_driver_version, get_redshift_jdbc_driver_version)
    ERB.new(File.read(template)).result(b)
  end

  def update_database_drivers_settings(template_path, template_filename)
    made_changes_to_original_settings = false
    original_settings_path = File.join(datagrip_settings_location, 'options', File.basename(template_filename, '.erb'))
    original_settings = Hash.from_xml(original_settings_path.read)

    template_settings = Hash.from_xml(load_template_settings(File.join(@@template_folder, template_filename)))

    template_settings['application']['component']['driver'].each do |driver|
      driver_name = driver['name']
      original_driver = original_settings['application']['component']['driver'][driver_name]

      if driver['library']['url'] != original_driver['library']['url']
        original_driver['library']['url'] = driver['library']['url']
        made_changes_to_original_settings = true
      end
    end

    if made_changes_to_original_settings
      write_xml_file(original_settings_path, settings)
    end
  end

  def update_datasources_settings(template_path, template_filename)
    made_changes_to_original_settings = false
    original_settings_path = File.join(datagrip_project_location, File.basename(template_filename, '.erb'))
    original_settings = File.read(original_settings_path)

    template_settings = Hash.from_xml(File.read(File.join(@@template_folder, template_filename)))

    template_settings['application']['component']['data-source'].each do |data_source|
      if not original_settings['application']['component'].has_key? data_source['name']
        original_settings['application']['component'] << data_source
        made_changes_to_original_settings = true
      end
    end

    if made_changes_to_original_settings
      write_xml_file(original_settings_path, settings)
    end
  end

  def write_xml_file(file, settings)
    fh = File.open(file, 'w')
    #fh.write(settings.to_xml)
    fh.close
  end

  def is_datagrip_installed?
    File.exist?('/Applications/DataGrip.app')
  end
end
