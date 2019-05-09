module Dryad
  module Consul
    MAJOR = 0
    MINOR = 1
    TINY  = 0
    PRE   = 'alpha'
  
    VERSION = [MAJOR, MINOR, TINY, PRE].compact.join(".")
  end
end
