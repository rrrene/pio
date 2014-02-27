# -*- coding: utf-8 -*-
require 'pio/arp/frame'
require 'pio/arp/message'
require 'pio/mac'

module Pio
  class Arp
    # ARP Request packet generator
    class Request < Message
      OPERATION = 1

      BROADCAST_MAC = Mac.new(0xffffffffffff)
      ALL_ZERO_MAC = Mac.new(0)

      private

      def default_options
        {
          operation: OPERATION,
          destination_mac: BROADCAST_MAC,
          target_hardware_address: ALL_ZERO_MAC
        }
      end

      def user_options
        @options.merge sender_hardware_address: @options[:source_mac]
      end

      def mandatory_options
        [
         :source_mac,
         :sender_hardware_address,
         :sender_protocol_address,
         :target_protocol_address
        ]
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
