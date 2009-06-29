# -*- coding: utf-8 -*-
require 'cairo'


def main
  Cairo::ImageSurface.new(298, 210) do |surface|
    context = Cairo::Context.new(surface)
    # background
    context.set_source_color(:white)
    context.paint
    # draw line
    context.set_source_color(:black)
    context.set_line_width(1)
    context.set_dash([2, 2, 2, 2], 0) # 点線
    context.move_to(0, 105)
    context.line_to(298, 105)
    context.stroke
    context.set_dash([1, 0, 1, 0], 0) # 点線解除
    context.set_dash([2, 2, 2, 2], 0) # 点線
    
    context.move_to(149, 0)
    context.line_to(149, 90)
    context.stroke
    
    context.move_to(0, 90)
    context.line_to(298, 90)
    context.stroke
    context.move_to(30, 0)
    context.line_to(30, 90)
    context.stroke
    context.move_to(268, 0)
    context.line_to(268, 90)
    context.stroke
    context.move_to(0, 120)
    context.line_to(134, 210)
    context.stroke
    context.move_to(298, 120)
    context.line_to(164, 210)
    context.stroke
    context.arc(75, 45, 35, - Math::PI, Math::PI)
    context.stroke
    context.arc(223, 45, 35, - Math::PI, Math::PI)
    context.stroke
    
    surface.write_to_png('test.png')
  end
end


main
