pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- tinyhawk
-- by morganquirk

#include levels.lua
#include util.lua
#include tiles.lua
#include tricks.lua
#include collision.lua
#include skater.lua
#include editor.lua
--#include game.lua
#include iso.lua

__gfx__
00000000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000088000000000000777700000000000000000000000000000fff0000000000000000000000000000006600000000000000000000000000000000000000
000000008080000000007777777700000000000000000000000000ffffff00000000000000000000000000066666000000000000000000000000000000000000
00000000800800000077777777777700000000000000000000000fffffffff000000000000000000000000066666660000000000000000000000000000000000
0000000000000000777777777777777777777777777777770000ffffffffffffffffffff00000000000000666666666655000000000000000000000000000000
000000000000000055777777777777115577777777777711000ffffffffffff155ffffffff0000000000006f6666666655550000000000000000008888000000
00000000000000005555777777771111555577777777111100ffffffffffff115555ffffffff0000000000f6f666666155555500000000000000880000880000
0000000000000000555555777711111155555577771111110ffffffffffff111555555ffffffff0000000fff6f6f666155555555000000000088000000008800
000000000000000055555555111111115555555511111111ffffffffffff1111555555551111111100000ffffff6f66155555555170000008800000000000088
00000000000000000055555511111100555555551111111100fffffffff1110000555555111111000000ffffffff6f1155555555177700000088000000008800
0000000000000000000055551111000055555555111111110000ffffff1100000000555511110000000f7fffffffff115555555511f7f7000000880000880000
000000000000000000000055110000005555555511111111000000fff100000000000055110000000777f7fffffff11155555555111f7f770000008888000000
0000000000000000000000000000000055555555111111110000000000000000000000000000000077777f7f7ffff11155555555111111110000000000000000
0000000000000000000000000000000000555555111111000000000000000000000000000000000000777777f7ff110000555555111111000000000000000000
00000000000000000000000000000000000055551111000000000000000000000000000000000000000077777f71000000005555111100000000000000000000
00000000000000000000000000000000000000551100000000000000000000000000000000000000000000777100000000000055110000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000770000000000000fff0000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000aa00000000000077770000000000ffffff00000000000000000000000000000000000000000000000000000000000aa0000000
000000000000000000000000aaaa00000000000077777700000000ffffffff000000000000000000000000000000000000000000000000000000000aa0000000
0000000000000000000000aaaa000000000000007777777700000fffffffffff0000000000000000000000000000000000000000000000000000000aa0000000
00000022220000000000aaaa1700000000000000777777110000fffffffffff1550000000000000000000077770000aaaaaaaaaaaaaaaaaa0000007aa7000000
00002222222200000000aa751777000000000000777711110000fffffffffff15555f00000000000000077777777aaaaaaaaaaaaaaaaaaaa0000777aa7770000
002222222222220000777775177777000000000077111111000fffffffffff11555555ff000000000077777777aaaa0000777775177777000077777aa7777700
222222222222222277777777777777770000000011111111000ffffffffff111555555551100000077777777aaaa177777777775177777777777777aa7777777
00222222222222000077777777777700000000001111111100fffffffffff1115555555511110000007777aaaa75170000777777777777000077777aa7777700
0000222222220000000077777777000000000000111111110fffffffffff11115555555511111000000077aa7775000000007777777700000000777777770000
0000002222000000000000777700000000000000111111110fffffffffff11115555555511111110000000777700000000000077770000000000007777000000
000000000000000000000000000000000000000011111111fffffffffff111115555555511111111000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000001111110000ffffffff1111000055555511111100000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000111100000000ffffff1100000000555511110000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000011000000000000fff10000000000005511000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000aa077770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000aa777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007aa777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
777aa777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007aa777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000aa777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000077770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00022800000022800002288000022880000228800007000077000000000000000000000000000000000000000000000000000000000000000000000000000000
00027780000027780002779000027790070277970077000077700000000000000000007700000000770000000000000000000000000000000000000000000000
00077090000077090007700000077000770776670770000007700722000000000000770000000000007700000000000000000000000000000000000000000000
00087000000777700080770077807777778077708777072287770772000000000077000000000000000077000000000000000000000000000000000000000000
00877000008777770777777777777770077777000877777208777678000000007700000000000000000000777777777777777777000000000000000000000000
00009000000790007777977000779700007797000777767807777698000000000000000000000000000000000000000000000000000000000000000000000000
00009900000099000099990000009000000909009909769899097700000000000000000000000000000000000000000000000000000000000000000000000000
00090000000900000000090000090900009000900990077709907770000000000000000000000000000000000000000000000000000000000000000000000000
00022800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00027780000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77807777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00779700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00090900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00900900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
777777777777777777777777777777777777777ff777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777777777777777777777777777777777ffffff7777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777ffffffffff77777777777777777777777777777777777777777777777777777777777777777777777777777777777
777777777777777777777777777777777ffffffffffffff777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777dffffffffffffff577777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777dddffffffffff55577777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777dddddffffff5555577777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777dddddddf8888555577777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777dddddddd8855555577777777777777777777777777777777777777777777777777777777777777777777777777777777
777777777777777777777777777777777ddddddd8585555777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777ddddd8558577777777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777777777777777777777777777777777ddd5557777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777576e77777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777775777657777777777777777777777777777777777777777777777777777777777777
7777777777777777777777777777777777777777777777777777777777777575555e777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777555550777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777060067777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777770000077777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777775005557777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777555577777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777

