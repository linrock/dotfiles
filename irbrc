require 'wirble'
require 'bond'
require 'ap'

require 'interactive_editor'
require 'looksee/shortcuts'

Wirble.init
Wirble.colorize
Bond.start

IRB.conf[:USE_READLINE] = true
IRB.conf[:AUTO_INDENT] = true

IRB::Irb.class_eval do
  def output_value
    ap @context.last_value
  end
end

class Object
  def local_methods
    (self.methods - Object.instance_methods).sort
  end
end
