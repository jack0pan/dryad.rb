module Dryad
  module Consul
    MAJOR = 0
    MINOR = 1
    TINY  = 1
    PRE   = nil
  
    VERSION = [MAJOR, MINOR, TINY, PRE].compact.join(".")
  end
end
