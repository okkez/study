# -*- coding: utf-8 -*-
str0 = "bar"
p str0[2, 1]         # => "r"
p str0[2, 0]         # => ""
p str0[2, 100]       # => "r"  (右側を超えても平気)
p str0[2, 1] == ?r   # => false  (左辺は長さ1の文字列、右辺は整数の文字コード)
p str0[-1, 1]        # => "r"
p str0[-1, 2]        # => "r" (飽くまでも「右に向かって len バイト」)

p str0[3, 1]         # => ""
p str0[4, 1]         # => nil
p str0[-4, 1]        # => nil
str1 = str0[0, 2]    # (str0の「一部」をstr1とする)
p str1               # => "ba"
str1[0] = "XYZ"
p str1               # => "XYZa" (str1の内容が破壊的に変更された)
p str0               # => "bar" (str0は無傷、str1はstr0と内容を共有していない)

str2="あいうえお"
p str2[4,1]
p str2[5,1]
p str2[6,1]
