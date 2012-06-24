require 'facter'

module NetworkHelper
  class Interface
    attr_accessor :interface

    IP_PATTERN = /inet addr\:(\d+\.\d+\.\d+\.\d+)/
    MASK_PATTERN = /Mask\:(\d+\.\d+\.\d+\.\d+)/
    BCAST_PATTERN = /Bcast\:(\d+\.\d+\.\d+\.\d+)/
    GATEWAY_PATTERN = /^0.0.0.0\s+(\d+\.\d+\.\d+\.\d+)\s+0.0.0.0/
    UNKNOWN_IP = "0.0.0.0"
    UNKNOWN_MASK = '255.255.255.255'
    UNKNOWN_BCAST = '0.0.0.0'
    UNKNOWN_GATEWAY = '0.0.0.0'

    def initialize(interface)
      self.interface = interface
    end

    def ifc_data
      @ifc_data ||= `ifconfig #{interface}`
    end

    def route_data
      @route_data ||= `route -n`
    end

    def ip
      if (match = ifc_data.match(IP_PATTERN))
        match[1]
      else
        UNKNOWN_IP
      end
    end

    def mask
      if (match = ifc_data.match(MASK_PATTERN))
        match[1]
      else
        UNKNOWN_MASK
      end
    end

    def bcast
      if (match = ifc_data.match(BCAST_PATTERN))
        match[1]
      else
        UNKNOWN_BCAST
      end
    end

    def gateway
      if (match = route_data.match(GATEWAY_PATTERN))
        match[1]
      else
        UNKNOWN_GATEWAY
      end
    end
  end
end

Facter.add(:network_ip) { setcode { NetworkHelper::Interface.new('eth0').ip } }
Facter.add(:network_mask) { setcode { NetworkHelper::Interface.new('eth0').mask } }
Facter.add(:network_gateway) { setcode { NetworkHelper::Interface.new('eth0').gateway } }
Facter.add(:network_bcast) { setcode { NetworkHelper::Interface.new('eth0').bcast } }
