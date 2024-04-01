pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- tinyhawk
-- by morganquirk

#include util.lua
#include collision.lua
#include skater.lua
#include editor.lua
#include iso.lua

__gfx__
0000000088880000000000077000000000000000c000000000000001100000000000000000000000000000000000000000000000000000000000000000000000
000000008800000000000777777000000000000cccc0000000000001111000000000000000000000000000000000000000000000000000000000000000000000
00000000808000000007777777777000000000ccccccc00000000001111110000000000000000000000000000000000000000000000000000000000000000000
0000000080080000077777777777777000000cccccccccc000000001111111100000000000000000000000000000000000000000000000000000000000000000
000000000000000017777777777777750000ccccccccccc500000011111111150000000000000000000000000000000000000000000000000000000000000000
00000000000000001117777777777555000ccccccccccc550000001c111111150000000000000000000000000000000000000000000000000000000000000000
0000000000000000111117777775555500ccccccccccc555000000c1c11111150000000000000000000000000000000000000000000000000000000000000000
000000000000000011111117755555550ccccccccccc555500000ccc1c1c11150000000000000000000000000000000000000000000000000000000000000000
00000000000000001111111155555555ccccccccccc5555500000cccccc1c1550000000000000000000000000000000000000000000000000000000000000000
000000000000000001111111555555500ccccccccc5555500000cccccccc1c550000000000000000000000000000000000000000000000000000000000000000
00000000000000000001111155555000000cccccc5555000000c7ccccccccc550000000000000000000000000000000000000000000000000000000000000000
0000000000000000000001115550000000000ccc555000000777c7ccccccc5550000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000077777c7c7cccc5550000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000007777777c7cc55500000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000777777c7550000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000777755000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000077700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000227700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000022772222700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000002277222222700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000222722222222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000002222722222222222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000222722222222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000002722222222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000022222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
