require 'erb'

class Template

  def initialize()
    erb = ERB.new(File.read('layout.html.erb'), nil, '-')
    erb.def_method(self.class, 'layout', 'layout.html.erb')
    erb = ERB.new(File.read('body.html.erb'), nil, '-')
    erb.def_method(self.class, 'body', 'body.html.erb')
  end

  def render
    layout{ body }
  end
end

puts Template.new.render
