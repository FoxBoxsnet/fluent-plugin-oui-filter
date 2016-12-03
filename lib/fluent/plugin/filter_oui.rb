require 'csv'

module Fluent::Plugin
  class OuiFilter < Filter
    Fluent::Plugin.register_filter('oui', self)

    config_param :database_path,        :string, :default => File.dirname(__FILE__) + '/../../../ouilist/ouilist.csv'
    config_param :mac_address,          :string, :default => 'mac_address'
    config_param :key_prefix_vendor,    :string, :default => 'vendor'
    config_param :key_prefix_oui,       :string, :default => 'oui'
    config_param :remove_prefix,        :string, :default => nil
    config_param :add_prefix,           :string, :default => nil

    def configure(conf)
      super
        @remove_prefix = Regexp.new("^#{Regexp.escape(remove_prefix)}\.?") unless conf['remove_prefix'].nil?
        @key_prefix_vendor    = @mac_address + "_" + @key_prefix_vendor
        @key_prefix_oui       = @mac_address + "_" + @key_prefix_oui
    end

    def filter_stream(tag, es)
      new_es = Fluent::MultiEventStream.new
      tag = tag.sub(@remove_prefix, '') if @remove_prefix
      tag = (@add_prefix + '.' + tag) if @add_prefix

        es.each do |time, record|
          unless record[@mac_address].nil?
            record[@key_prefix_oui]    = getoui(record[@mac_address]) rescue nil
            record[@key_prefix_vendor] = getouiname(getoui(record[@mac_address])) rescue nil
          end
            new_es.add(time, record)
        end
        return new_es
    end

    def getoui(macaddress)
      macaddress = macaddress.gsub(/[0-9a-fA-F:]{1,8}$/, '')
      macaddress = macaddress.gsub(/:/, '')
      macaddress = macaddress.upcase

      return macaddress
    end

    def getouiname(ouiaddress)
      CSV.open(@database_path,"r") do |csv|
        csv.each do |row|
          if row[0] == macaddress
            return row[1]
          end
        end
      end
    end
  end
end