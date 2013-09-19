require "pio/lldp/port-description-value"
require "pio/lldp/system-name-value"
require "pio/lldp/system-description-value"
require "pio/lldp/system-capabilities-value"
require "pio/lldp/management-address-value"
require "pio/lldp/organizationally-specific-value"
require "pio/lldp/end-of-lldpdu-value"


module Pio
  class Lldp
    # Optional TLV and End Of LLDPDU
    class OptionalTlv < BinData::Record
      endian :big

      bit7 :tlv_type
      bit9 :tlv_info_length
      choice :tlv_value,
             :read_length => :tlv_info_length,
             :onlyif => lambda { not end_of_lldpdu? },
             :selection => :chooser do
        end_of_lldpdu_value 0
        port_description_value 4
        system_name_value 5
        system_description_value 6
        system_capabilities_value 7
        management_address_value 8
        organizationally_specific_value 127
        string "unknown"
      end


      def end_of_lldpdu?
        tlv_type == 0
      end


      def chooser
        if valid_optional_tlv?
          tlv_type
        else
          "unknown"
        end
      end


      ##########################################################################
      private
      ##########################################################################


      def valid_optional_tlv?
        optional_tlv? or end_of_lldpdu_tlv?
      end


      def optional_tlv?
        tmp_tlv_type = tlv_type
        4 <= tmp_tlv_type and tmp_tlv_type <= 127
      end


      def end_of_lldpdu_tlv?
        tlv_type == 0
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
