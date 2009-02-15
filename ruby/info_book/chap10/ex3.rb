# -*- coding: utf-8 -*-

require 'ex1'
require 'ex2'

class Stations

  Node = Struct.new(:name, :siblings, :dist)
  
  attr_reader :graph
  
  def initialize
    @graph = {}
    cn('赤羽', '池袋')
    cn('赤羽', '田端')
    cn('池袋', '田端')
    cn('池袋', '新宿')
    cn('八王子', '立川')
    cn('八王子', '横浜')
    cn('立川', '新宿')
    cn('立川', '川崎')
    cn('新宿', 'お茶の水')
    cn('新宿', '大崎')
    cn('お茶の水', '秋葉原')
    cn('お茶の水', '東京')
    cn('田端', '秋葉原')
    cn('東京', '品川')
    cn('大崎', '品川')
    cn('大崎', '横浜')
    cn('品川', '川崎')
    cn('川崎', '横浜')
    cn('東京', '秋葉原')
  end
  
  def cn(name1, name2)
    @graph[name1] = Node.new(name1, [], -1) if @graph[name1].nil?
    @graph[name2] = Node.new(name2, [], -1) if @graph[name2].nil?
    @graph[name1].siblings.push(@graph[name2])
    @graph[name2].siblings.push(@graph[name1])
  end
  
  def travarse_with_stack(start, goal)
    stack = Stack1.new
    n = @graph[start]
    n.dist = 0
    stack.push(n)
    puts "START: #{start}"
    until stack.empty?
      n = stack.pop
      n.siblings.size.times do |i|
        n1 = n.siblings[i]
        if n1.dist < 0
          n1.dist = n.dist + 1
          puts "#{n1.dist}: #{n1.name}"
          return if goal == n1.name
          stack.push(n1)
        end
      end
    end
  end

  def travarse_with_queue(start, goal)
    queue = Queue1.new
    n = @graph[start]
    n.dist = 0
    queue.enq(n)
    puts "START: #{start}"
    until queue.empty?
      n = queue.deq
      n.siblings.size.times do |i|
        n1 = n.siblings[i]
        if n1.dist < 0
          n1.dist = n.dist + 1
          puts "#{n1.dist}: #{n1.name}"
          return if goal == n1.name
          queue.enq(n1)
        end
      end
    end
  end
end


s = Stations.new
s.travarse_with_stack('横浜', '池袋')
s = Stations.new
s.travarse_with_queue('横浜', '池袋')
s = Stations.new
s.travarse_with_stack('東京', '八王子')
s = Stations.new
s.travarse_with_queue('東京', '八王子')
s = Stations.new
s.travarse_with_stack('横浜', '赤羽')
s = Stations.new
s.travarse_with_queue('横浜', '赤羽')
# >> START: 横浜
# >> 1: 八王子
# >> 1: 大崎
# >> 1: 川崎
# >> 2: 立川
# >> 2: 品川
# >> 3: 東京
# >> 4: お茶の水
# >> 4: 秋葉原
# >> 5: 田端
# >> 6: 赤羽
# >> 6: 池袋
# >> START: 横浜
# >> 1: 八王子
# >> 1: 大崎
# >> 1: 川崎
# >> 2: 立川
# >> 2: 新宿
# >> 2: 品川
# >> 3: 池袋
# >> START: 東京
# >> 1: お茶の水
# >> 1: 品川
# >> 1: 秋葉原
# >> 2: 田端
# >> 3: 赤羽
# >> 3: 池袋
# >> 4: 新宿
# >> 5: 立川
# >> 5: 大崎
# >> 6: 横浜
# >> 7: 八王子
# >> START: 東京
# >> 1: お茶の水
# >> 1: 品川
# >> 1: 秋葉原
# >> 2: 新宿
# >> 2: 大崎
# >> 2: 川崎
# >> 2: 田端
# >> 3: 池袋
# >> 3: 立川
# >> 3: 横浜
# >> 3: 赤羽
# >> 4: 八王子
# >> START: 横浜
# >> 1: 八王子
# >> 1: 大崎
# >> 1: 川崎
# >> 2: 立川
# >> 2: 品川
# >> 3: 東京
# >> 4: お茶の水
# >> 4: 秋葉原
# >> 5: 田端
# >> 6: 赤羽
# >> START: 横浜
# >> 1: 八王子
# >> 1: 大崎
# >> 1: 川崎
# >> 2: 立川
# >> 2: 新宿
# >> 2: 品川
# >> 3: 池袋
# >> 3: お茶の水
# >> 3: 東京
# >> 4: 赤羽
