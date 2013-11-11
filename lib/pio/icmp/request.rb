# -*- coding: utf-8 -*-
require 'pio/icmp/message'

module Pio
  class Icmp
    # ICMP Request packet generator
    class Request < Message
      TYPE = 8
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
