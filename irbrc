require 'rubygems'
require 'wirble'
require 'bond'
require 'ap'
require 'looksee/shortcuts'

Wirble.init
Wirble.colorize
Bond.start

class Object
    def local_methods
        (self.methods - Object.instance_methods).sort
    end
end
