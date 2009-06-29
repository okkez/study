# -*- coding: utf-8 -*-
require 'cairo'

def main
  #Cairo::PDFSurface.new('papermask.pdf', Cairo::Paper::A4_LANDSCAPE) do |surface|
  Cairo::SVGSurface.new('papermask.svg', Cairo::Paper::A4_LANDSCAPE) do |surface|
    context = Cairo::Context.new(surface)
    # background
    context.set_source_color(:white)
    context.paint
    # draw line
    context.set_source_color(:black)
    context.set_line_width(1)
    context.set_dash([2, 2, 2, 2], 0) # 点線
    context.move_to(0, mm2pt(105))
    context.line_to(mm2pt(297), mm2pt(105))
    context.stroke
    context.set_dash([1, 0, 1, 0], 0) # 点線解除
    context.set_dash([2, 2, 5, 2], 0) # 点線
    context.move_to(mm2pt(149), 0)
    context.line_to(mm2pt(149), mm2pt(90))
    context.stroke
    context.set_dash([1, 0, 1, 0], 0) # 点線解除
    context.move_to(mm2pt(149), mm2pt(90))
    context.line_to(mm2pt(149), mm2pt(210))
    context.stroke

    context.move_to(0, mm2pt(90))
    context.line_to(mm2pt(30), mm2pt(90))
    context.stroke
    context.set_dash([2, 2, 5, 2], 0) # 点線
    context.move_to(mm2pt(30), mm2pt(90))
    context.line_to(mm2pt(267), mm2pt(90))
    context.stroke
    context.set_dash([1, 0, 1, 0], 0) # 点線解除
    context.move_to(mm2pt(267), mm2pt(90))
    context.line_to(mm2pt(297), mm2pt(90))
    context.stroke

    context.move_to(mm2pt(30), 0)
    context.line_to(mm2pt(30), mm2pt(90))
    context.stroke
    context.move_to(mm2pt(267), 0)
    context.line_to(mm2pt(267), mm2pt(90))
    context.stroke
    context.move_to(0, mm2pt(120))
    context.line_to(mm2pt(134), mm2pt(210))
    context.stroke
    context.move_to(mm2pt(297), mm2pt(120))
    context.line_to(mm2pt(164), mm2pt(210))
    context.stroke
    context.set_dash([2, 2, 5, 2], 0) # 点線
    context.arc(mm2pt(75), mm2pt(45), mm2pt(35), - Math::PI, Math::PI)
    context.stroke
    context.arc(mm2pt(223), mm2pt(45), mm2pt(35), - Math::PI, Math::PI)
    context.stroke

    # 枠
    context.set_dash([1, 0, 1, 0], 0) # 点線解除
    context.move_to(0, 0)
    context.line_to(0, mm2pt(210))
    context.line_to(mm2pt(297), mm2pt(210))
    context.line_to(mm2pt(297), 0)
    context.stroke

    context.show_page
  end
end

def mm2pt(size_mm)
  mm = Cairo::Paper::A4_LANDSCAPE.size("mm").first
  pt = Cairo::Paper::A4_LANDSCAPE.size("pt").first
  (pt / mm) * size_mm
end

main
