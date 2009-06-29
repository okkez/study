# -*- coding: utf-8 -*-
require 'cairo'

def main
  $count = 0
  #Cairo::PDFSurface.new('papermask.pdf', Cairo::Paper::A4_LANDSCAPE) do |surface|
  Cairo::SVGSurface.new('circle.svg', Cairo::Paper::A4_LANDSCAPE) do |surface|
    context = Cairo::Context.new(surface)
    # background
    context.set_source_color(:white)
    context.paint
    # draw line
    context.set_source_color(:gray)
    context.set_line_width(1)

    # draw circle
    r = ARGV[0].to_f
    i = 0
    10.times do |n|
      i += draw_circles(context, n, r, 10)
    end
    p i
    # 枠
    context.set_source_color(:black)
    context.set_dash([1, 0, 1, 0], 0) # 点線解除
    context.move_to(mm2pt(10), mm2pt(10))
    context.line_to(mm2pt(10), mm2pt(200))
    context.line_to(mm2pt(287), mm2pt(200))
    context.line_to(mm2pt(287), mm2pt(10))
    context.line_to(mm2pt(10), mm2pt(10))
    context.stroke

    context.show_page
  end
end

def mm2pt(size_mm)
  mm = Cairo::Paper::A4_LANDSCAPE.size("mm").first
  pt = Cairo::Paper::A4_LANDSCAPE.size("pt").first
  (pt / mm) * size_mm
end

def draw_circles(context, count, r, margin)
  i = 0
  x0 = case count % 2
       when 0 then r + margin
       when 1 then 2 * r + margin
       end
  y  = y0(count, r, margin)
  return 0 if y + r > 200
  x0.step(277, 2*r) do |x|
    #context.circle(mm2pt(x), mm2pt(y), mm2pt(r))
    #context.stroke
    # render text
    context.set_font_size(32)
    extents = context.text_extents($count.to_s)
    p [mm2pt(x), mm2pt(y), extents.width, extents.height, extents.x_bearing, extents.y_bearing]
    context.move_to(mm2pt(x) - (extents.width/2 + extents.x_bearing),
                    mm2pt(y) - (extents.height/2 + extents.y_bearing))
    context.set_source_color(:black)
    context.show_text($count.to_s)
    context.stroke
    $count += 1
    # render circle
    context.set_source_color(:gray)
    context.circle(mm2pt(x), mm2pt(y), mm2pt(r-1))
    context.stroke
    i += 1
  end
  i
end

def y0(count, r, margin)
  return margin + r if count == 0
  margin + r + r * Math.sqrt(3) * count
end

main
