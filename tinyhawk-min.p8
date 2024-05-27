pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
cartdata"tinyhawk_0"function load(n)map={}all_entities={}local n=LEVELS[n]local n=split(n,":")minx,maxx,minz,maxz,LEVEL_PALETTE,level_name,level_start=unpack(split(n[1],"/"))local o,n,e=n[2],0,maxz-minz+1for o in all(split(o,";",false))do local l,e=n%e,n\e if#o>0then local n=split(o,",")if(n)add_map_tile(e+minx,l+minz,n[1],n[2],n[3]==1,n[4]==1,n[5])
end n+=1end end LEVELS={"-17/1/-9/19/1,2,3,5,140,15,7,8,9,10,139,12,140,14,134,0/wAREHOUSE/-1.5,2,-5.5:;;;;;;;;;;;;;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;;;;;;;;;;;;;;1,4,1;1,4,1;1,0.5,1,1;1,0.5,1,1;1,0.5,1,1;1,0.5,1,1;1,0.5,1,1;1,0.5,1,1;;;;;;;3,0,1,1;1,0.5,1,1;;;;;;;;;;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,0.5,1,1;1,0.5,1,1;1,0.5,1,1;;;;;18;;18;;18;3,0,1,1;1,0.5,1,1;;;;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;1,4,1;;;35,0,0,0,4;35,0,0,0,4;35,0,0,0,4;;;;;;35,0,0,0,3;35,0,0,0,3;35,0,0,0,3;;;;3,0,1,1;1,0.5,1,1;;;;1,4,1;3,1,1;1,0.5,0,1;1,0.5,1;17,1,0,1;3,0,1;;;;;35,0,0,0,4;35,0,0,0,4;35,0,0,0,4;2,0,1,1,4;;13;;2,0,1,0,3;35,0,0,0,3;18,0,0,0,3;35,0,0,0,3;18;;18;3,0,1,1;1,0.5,1,1;;;;1,4,1;3,1,1;1,0.5,1;16,1,0,1;17,1,0,1;3,0,1;;;;;35,0,0,0,4;35,0,0,0,4;35,0,0,0,4;2,0,1,1,4;;12;;2,0,1,0,3;35,0,0,0,3;35,0,0,0,3;35,0,0,0,3;;;;3,0,1,1;1,0.5,1,1;;;;1,4,1;3,1,1;1,0.5,1;1,0.5,1;17,1,0,1;3,0,1;;;;;35,0,0,0,4;35,0,0,0,4;35,0,0,0,4;;;;;;35,0,0,0,3;18,0,0,0,3;35,0,0,0,3;18;;;3,0,1,1;1,0.5,1,1;;;;1,4,1;3,1,1;1,0.5,1;16,1,0,1;17,1,0,1;3,0,1;;;;;;;;;;2,0,0,1;;;;;;3,0,0,1;3,0,0,1;3,0,0,1;10;1,0.5,1,1;;;;1,4,1;3,1,1;1,0.5,1;1,0.5,0,1;17,1,0,1;3,0,1;;;;;;4,0,1;4,0,1;4,0,1;4,0,1;4,0,1;4,0,1;;;18;3,0,1,1;1,0.5,1,1;1,0.5,1,1;1,0.5,1,1;1,0.5,1,1;1,0.5,1,1;;;;1,4,1;3,1,1;1,0.5,1;16,1,0,1;17,1,0,1;3,0,1;;;;;;;16;2;2;16;;;;;;3;3;3;11;1,0.5,1,1;;;;1,4,1;3,1,1;1,0.5,1;1,0.5,1;17,1,0,1;3,0,1;;;;;;;;;;;;;;18;;18;;18;3,0,1,1;1,0.5,1,1;1,4,1;1,4,1;1,4,1;1,4,1;3,1,1;1,0.5,1;1,0.5,1;17,1,0,1;3,0,1;;;;;;;;;;;;;;;;;;;3,0,1,1;1,0.5,1,1;3,2,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;5,1,1;2,0.5,1;2,0,1;;;;2,0,1,1,1;2,0.5,1,1,1;3,0,1,0,5;;15;;3,0,1,1,5;2,0.5,1,0,2;2,0,1,0,2;;18;;18;;18;3,0,1,1;1,0.5,1,1;3,2,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;5,1,1;2,0.5,1;2,0,1;;;;2,0,1,1,1;2,0.5,1,1,1;3,0,1,0,5;;14;;3,0,1,1,5;2,0.5,1,0,2;2,0,1,0,2;;;;;;;3,0,1,1;1,0.5,1,1;3,2,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;1,4,1;1,4,1;3,0,1;;;;2,0,1,1,1;2,0.5,1,1,1;3,0,1,0,5;15;;;3,0,1,1,5;2,0.5,1,0,2;2,0,1,0,2;;18;;18;;18;3,0,1,1;1,0.5,1,1;3,2,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;16,2;5,1,1;2,0.5,1;2,0,1;;;;2,0,1,1,1;2,0.5,1,1,1;3,0,1,0,5;;14;;3,0,1,1,5;2,0.5,1,0,2;2,0,1,0,2;;;;;;;3,0,1,1;1,0.5,1,1;3,2,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;16,2;5,1,1;2,0.5,1;2,0,1;;;;2,0,1,1,1;2,0.5,1,1,1;3,0,1,0,5;;15;;3,0,1,1,5;2,0.5,1,0,2;2,0,1,0,2;;18;;18;;18;3,0,1,1;1,0.5,1,1;3,2,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1;1,1.5,1,1;3,0,1;;;;2,0,1,1,1;2,0.5,1,1,1;3,0,1,0,5;;15;;3,0,1,1,5;6,0.5,1;6,0.5,1;6,0.5,1;3,0,0,1;3,0,0,1;3,0,0,1;3,0,0,1;3,0,0,1;10;1,0.5,1,1;3,2,1;17,2,1,1;17,2,1,1;17,2,1,1;17,2,1,1;17,2,1,1;17,2,1,1;17,2,1,1;3,0,1;;;;2,0,1,1,1;2,0.5,1,1,1;3,0,1,0,5;;14;;3,0,1,1,5;1,0,1;1,0,1;1,0,1;1,0.5;1,0.5;1,0.5;1,0.5;1,0.5;1,0.5,1,1;1,0.5,1,1;","-16/1/-6/22/129,2,3,1,1,12,7,8,9,10,139,12,140,14,5,0/cITY/-7,0,4:3,1.5,1;1,1,1;1,1;1,1;1,1;1,1;3,1.5,1,1,4;3,0,1,0,3;;26;;3,0,1,1;1,1,1;1,1,1;5,0.5,1;1;1;1;1;1;1;1;1;1;1,0,1;1,0,1;1,0,1;1,0,0,1;1,0,0,1;3,1.5,1;1,1,1;1,1;1,1;1,1;1,1;3,1.5,1,1,4;3,0,1,0,3;;26;;3,0,1,1;16,1,1,1;16,1,1,1;2,0.5,1;1;1;14,0.5,1,1;1;1;2,0.5,1,1;1;1;22,0.5,1,1;4,0.5,1,1;4,0.5,1,1;1,0,1;1,0,0,1;1,0,0,1;3,1.5,1;1,1,1;1,1;1,1;1,1;1,1,1,1;3,1.5,1,1,4;3,0,1,0,3;;26;;3,0,1,1;16,1,1,1;16,1,1,1;2,0.5,1;1;1;1;1;1;1;1;7,0.5,1;1;1,0,1;1,0,1;1,0,1;1,0,0,1;1,0,0,1;1,1,1;1,1;1,1;1,1;1,1;1,1;1,1,1,1;;;26;;;1;1;1;22,0.5,1,1;4,0.5,1,1;4,0.5,1,1;4,0.5,1,1;4,0.5,1,1;22,0.5,1;22,0.5,0,1;1,0,1;2,0.5,1;1,0,1;1,0,1;1,0,1;1,0,0,1;1,0,0,1;25,1.5,0,1;1,1;1,1;25,1.5,0,1;25,1.5,0,1;1,1;25,1.5,1,1;;;26;;;1,0,1;1;22,0.5,0,1;1;1;1,0,1;1,0,1;1,0,1;1,0,1;4,0.5;1,0,1;1,0,1;1,0,1;15,0.5,1,1;1,0,1;1,0,0,1;1,0,0,1;29,0,1;5;5;1,0.5,0,1;1,0.5,0,1;25,1.5,1;25,1.5,1,1;;;26;;25;25;;;;;1;1,0.5;1,1;19;20;19;1,1;1,0.5;1;25,0,1,1;;2;29,0,1;;;1,0.5,0,1;1,0.5,0,1;25,1.5,1;17,1.5,0,1,5;;;26;;;;29,0,1,1;29,0,1;;27,0,1;;;;27,0,1;4;27,0,1;;27,0,1;;29,0,1,1;29,0,1;27,0,1,1;29,0,1;;;1,0.5,0,1;1,0.5,0,1;25,1.5,1;17,1.5,0,1,5;;;26;;;;29,0,1,1;29,0,1;;;;;;;21,0,0,1;;;;;29,0,1,1;29,0,1;;29,0,1;;;1,0.5,0,1;1,0.5,0,1;25,1.5,1;17,1.5,0,1,5;;;26;;;;29,0,1,1;29,0,1;26,0,1;26,0,1;26,0,1;26,0,1;26,0,1;7;26,0,1;26,0,1;26,0,1;26,0,1;26,0,1;26,0,1;26,0,1,1;26,0,1,1;;;;5;5;1,1;17,1.5,0,1,5;;;26;;;;29,0,1,1;29,0,1;;;;;22,0,0,1;;;;;;;;;;;;;;;1,1;17,1.5,0,1,5;;;26;;;;;27,0,1;;27,0,1;;27,0,1;22;27,0,1;;27,0,1;;27,0,1;;27,0,1,1;;27,0,1,1;29,0,1;;;;;1,1;17,1.5,0,1,5;;;26;32,0,1,0,6;31,0,1,0,6;;;;;;;;;21,0,1;4,0,1;4,0,1;;;;;;;29,0,1;;18,0,0,0,2;4,0,1;20,0,1,1;4,0.5,1;4,0.5,1;20,0,1;4,0,1;26,0,0,0,1;;;;;;;;25,0,0,1;25,0,0,1;25,0,0,1;;;;;2,0,0,1;2,0,0,1;2,0,0,1;2,0,0,1;2,0,0,1;29,0,1;;18,0,0,1,2;18,0,0,1,2;19,0,1,1;1;1;19,0,1;18,0,1,0,1;26,0,0,1,1;;;;2,0,1,1;1;1,0,1,1;2,0.5,1,1;1,0,1;1,0,1;1,0,1;2,0.5,1;1,0,1;1,0,1;1,0,1;1,0,1;1,0,1;1,0,1;1,0,1,1;3,0.5,1,1;29,0,1;;18,0,0,1,2;18,0,0,1,2;19,0,1,1;1;1;19,0,1;18,0,1,0,1;26,0,0,0,1;;;;2,0,1,1;1,0,0,1;1;2,0.5,1,1;1;15,0.5,1,1;1;2,0.5,1;1;1,0,1,1;1,0,1,1;1;1,0,0,1;1,0,1,1;1,0,1,1;3,0.5,1,1;;;18,0,0,0,2;4,0,1;20,0,1,1;4,0.5,1;4,0.5,1;20,0,1;4,0,1;26,0,0,0,1;;;;2,0,1,1;1,0,0,1;1,0,0,1;1;1;1;1;1;1;1,0,1,1;1,0,1,1;1;1;1,0,1,1;1,0,1,1;3,0.5,1,1;;;18,0,0,0,2;18,0,0,0,2;19,0,1,1;1;1;19,0,1;29,0,0,1;29,0,0,1;29,0,0,1;29,0,0,1;29,0,0,1;;1,0,0,1;1,0,0,1;14,0.5,1,1;1;1;1,0,1,1;1,0,1,1;1,0,1,1;1,0,1,1;1,0,1,1;1,0,1,1;1,0,1,1;21,0.5,0,1;1,0,0,1;3,0.5,1,1;1,0,1;1,0,1;1,0,1;1,0,1;1,0.5;1,0.5;1,0.5;1,0.5;29;29;29;29;29;;1,0,1,1;1,0,1,1;25,0.5,0,1;25,0.5,0,1;25,0.5,0,1;25,0.5,0,1;25,0.5,0,1;22,1,1,1;4,1,1,1;20,0.5,1;4,0.5,1;21,0.5,1,1;1,0,1,1;1,0,1,1;3,0.5,1,1;","-17/1/-8/20/130,2,3,5,133,15,7,8,9,10,139,12,133,14,134,0/sCHOOL/-15,2,16:1,2,1;3;3;3;30;;30;;;;;3,0,0,0,7;3,0,0,0,7;3,0,0,0,7;20;;;3,2,0,0,8;3,2,0,0,8;3,2,0,0,8;6,2,1;6,2,1;6,2,1;6,2,1;6,2,1;6,2,1;6,2,1;6,2,1;6,2,1;3,0,1;30;33;30;30;;;;;;;;;;4,0,0,1;;;1,1.5,1,1;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;3,0,1;30;33;33;;;;;;;;;;;4,0,0,1;;;1,1.5,1,1;16,2;16,2;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;1,1.5;3,0,1;30;30;30;;;7,1.5,1,1;1,1,1,1;;;;;;;4,0,0,1;;;1,1.5,1,1,4;16,2;16,2;1,1.5;22,2,1,1;4,2,1,1;4,2,1,1;1,1.5;1,1.5;1,1.5;2,1.5;2,1.5;;30;;30;;;1,1,1,1;1,1;;;2,0,1;;;;4,0,0,1;;;1,1.5,1,1,4;16,2;16,2;22,2,0,1;5;5;1,1.5,1,1;1,1.5;1,1.5;1,1.5;2,1;2,1;;;;;4,0,0,1;;1,1;1,1;28,0,1;;2,0,1;;;;4,0,0,1;;;1,2,0,1;19,1.5,0,0,4;19,1.5,0,0,4;20,1.5;;;1,1.5,1,1;1,1.5;3,1,1;1,0.5;1,0.5;1,0.5;;;2,0,0,1;;4,0,0,1;;2,1.5,0,1,1;2,1.5,0,1,1;;;;;;;20,0,0,1;;;1,2,0,1;19,1;19,1;20,1;;;1,1.5,1,1;1,1.5;3,1,1;1,0.5;1,0.5;1,0.5;;;1,0,0,1;;22;;;;;;;;;;;;;1,2,0,1;19,0.5;19,0.5;20,0.5;;;1,1.5,1,1;1,1.5;3,1,1;1,0.5;1,0.5;1,0.5;4,0,0,1;;1,0,0,1;;;21,0,1;4,0,1;4,0,1;4,0,1;4,0,1;22,0,1;;;;;;;1,1.5,0,1;19;19;20;;;;;1,0.5;1,0.5;1,0.5;1,0.5;4,0,0,1;;2;;;;;;;;;8;;;1,1,1,1,3;1,1,1,1,3;1,1;1,1;16,0,1,1,5;16,0,1,1,5;4;16,0,1,1,5;;;;1,0.5;1,0.5;1,0.5;1,0.5;4,0,0,1;;;;;;;1,1,1,1,6;1,1,1,1,6;1,1,1,1,6;2,1.5,1,1,2;;21;;1,1,1,1,3;1,1,1,1,3;1,1;1,1;16,0,1,1,5;16,0,1,1,5;16,0,1,1,5;16,0,1,1,5;;;;1,0.5;1,0.5;1,0.5;1,0.5;20,0,0,1;;;;;;;6,1.5,1,1,6;6,1.5,1,1,6;6,1.5,1,1,6;2,1.5,1,1,2;;4,0,0,1;30;28;;;1,3.5;16,0,1,1,5;16,0,1,1,5;16,0,1,1,5;16,0,1,1,5;;;;1,0.5;1,0.5;1,0.5;1,0.5;;;;;;;;30;;30;33;30;30;30;;;;1,3.5;;;;;;;;2,0.5;2,0.5;3;3;;;;;;;;;;30;33;33;;;2,0,0,1;;;;;;;;;;;2;2;;;4,1,0,1;1,0.5;1,0.5;1,0.5;2,0.5,1;1;1;1;19,0,1;;30;33;30;2,0,1,1;1;2,0,1;;;;;;;;;;;;;;22,1;1,0.5;1,0.5;1,0.5;2,0.5,1;1;1;1;19,0,1;;30;;30;;2;33;30;30;;30;;;;;;;;;;1,0.5;21,1,1;4,1,1;4,1,1;20,0.5,1;22,0.5,1;1;1;19,0,1;30;33;33;33;30;30;30;30;;;30;30;;;;;;;;;3,1,1;1,0.5;1,0.5;1,0.5;19,0.5,1;1;21,0.5,1;4,0.5,1,1;2,0,1;;30;33;30;;30;2,0,1,1;1,0,1;1,0,1;1,0,1;30;30;1,0,1;1,0,1;1,0,1;2,0,1;;;;;3,1,1;1,0.5;1,0.5;1,0.5;19,0.5,1;1;1;1;2,0,1;;30;30;30;30;30;2,0,1,1;1,0,1;1,0,1;1,0,1;3,0,0,1;3,0,0,1;1,0,1;1,0,1;1,0,1;2,0,1;;;3,0,0,1;3,0,0,1;"}p8cos=cos function cos(n)return p8cos(n/6.283)end p8sin=sin function sin(n)return-p8sin(n/6.283)end p8atan2=atan2 function atan2(n,e)return p8atan2(n,-e)*6.2818end function v_add(n,e)return{n[1]+e[1],n[2]+e[2],n[3]+e[3]}end function v_sub(n,e)return{n[1]-e[1],n[2]-e[2],n[3]-e[3]}end function v_mul(n,e)return{n[1]*e,n[2]*e,n[3]*e}end function v_mag(n)local e=max(max(abs(n[1]),abs(n[2])),abs(n[3]))local n,o,l=n[1]/e,n[2]/e,n[3]/e return(n*n+o*o+l*l)^.5*e end function v_mag_sq(n)local e=max(max(abs(n[1]),abs(n[2])),abs(n[3]))local n,o,l=n[1]/e,n[2]/e,n[3]/e return(n*n+o*o+l*l)*e end function v_norm(n)local e=v_mag(n)return{n[1]/e,n[2]/e,n[3]/e}end function v_cross(n,e)return{n[2]*e[3]-e[2]*n[3],n[3]*e[1]-e[3]*n[1],n[1]*e[2]-e[1]*n[2]}end function v_dot(n,e)return n[1]*e[1]+n[2]*e[2]+n[3]*e[3]end function v_zero()return{0,0,0}end function v_copy(n)return{n[1],n[2],n[3]}end function v_fwd_lateral(e,n,o,l,f)local n=v_norm{n[1],f and 0or n[2],n[3]}local f={n[3],n[2],-n[1]}return v_add(e,v_add(v_mul(n,o),v_mul(f,l)))end function v_flat(n)return{n[1],0,n[3]}end function v2p(n)return{n[1]*-8+n[3]*8+64,n[1]*4+n[3]*4+n[2]*-8+64}end function p2v(n)local n,e=n[1]-64-scroll[1],n[2]-64-scroll[2]return{(n/-8+e/4)/2,0,(e/4+n/8)/2}end function insert_cmp(n,e,l)for o=1,#n do if(l(n[o],e))add(n,e,o)return
end add(n,e,i)end function sign(n)return n>0and 1or-1end function get_cells_within(n,e)local o={}for l=n[1]-e,n[1]+e do for n=n[3]-e,n[3]+e do local n=get_cell{l,0,n}if(n)add(o,n)
end end return o end function pr(n,e)return sin(v_dot({n,e,0},v_mul({12.9898,78.233,0},20.0437)))%1end function gprint(o,e,l,f,t)local i,n,d=0,1,t and time\t or 0while n<=#o do local t=o[n]if(t=="ᶜ")f=tonum(o[n+1],1)n+=1else i=pr(e,l+d)*1.8e=print(t,e+0,l+i,f)
n+=1end return e end function grungeline(e,o,l,f,t)tt=time\12*10for n=l,f,.5do local e,o,l,n=e+pr(e,n+tt)*4,o+pr(o,n+tt)*4,n+pr(l,n+tt)*3-pr(tt+1,tt)*3,n+pr(f,n+tt)*3-pr(tt,tt+1)*3line(e,l,o,n,t)line(e+1,l+1,o+1,n+1,t)end end function grungebutton(o,e,n,f,t)local l=print(o,0,-10)local e=e-l/2grungeline(e-7,e+l+7,n-2,n+7,t)sprint(o,e,n,f)end function sprint(n,e,o,l)print(n,e,o+1,0)print(n,e,o,l)end function transition()skatesnd(49)fillps=split"0b0101101001011010.1, 0b1010010110100101.1, 0b1011111010111110.1, 0b1111101011111010.1"local e={}for o=0,47do local n=sin(o/15)*6+15function cf(n,o,l,f)fillp(rnd(fillps))circfill(n,o,l,f)if(rnd()<.02)add(e,{n,o,min(l,4),rnd()})
end function paint(e,o)for l=0,5do theta=rnd()*6.2818local n,l=cos(theta)*(n+rnd()*7-1),sin(theta)*(n+rnd()*7-1)cf(e+n,o+l,rnd(3)+3,0)end cf(e,o,n,0)end for n=0,6do local n=o+n/7local e=cos(n/2)*-64+64local n=n*3.5-e/4paint(e,n)end fillp()for n in all(e)do for e=1,6do circfill(n[1],n[2],n[3],0)n[2]+=n[4]n[4]-=.004end end flip()end fillp()end function skatesnd(n,e)if(n>=stat(46)and time~=last_sound_time)sfx(n,0,rnd(e)\1,e and 2or-1)last_sound_time=time
end function parse_volume(e)local n={}for e in all(split(e,";"))do local e,o,l,f,t,i=unpack(split(e,","))add(n,{pt={e,o,l},normal={f,t,i}})end return n end empty_volumes={}ground_volume={{{pt=v_zero(),normal={0,1,0}}},v_zero()}vols_str=[[block_volumes=-0.5,0,0,-1,0,0;0.5,0,0,1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,0.5,0,0,1,0
hblock1_volumes=0,0,0,-.7071,0,-.7071;0.5,0,0,1,0,0;0,0,0.5,0,0,1;0,1,0,0,1,0
hblock2_volumes=0,0,0,.7071,0,-.7071;-0.5,0,0,-1,0,0;0,0,0.5,0,0,1;0,1,0,0,1,0
ramp_volumes=-0.5, 0, 0,-1, 0, 0;0, 0, -0.5,0, 0, -1;0, 0, 0.5,0, 0, 1;0, 0.25, 0,0.4472,0.8944,0
ramp2_volumes=-0.5, 0, 0,-1, 0, 0;0, 0, -0.5,0, 0, -1;0, 0, 0.5,0, 0, 1;0, 0.5, 0,0.7071,0.7071,0
rail1_volumes=-0.5, 0, 0,-1, 0, 0;0.5, 0, 0,1, 0, 0;0, 0, -0.1,0, 0, -1;0, 0, 0.1,0, 0, 1;0, 0.5, 0,0, 1, 0
rail2_volumes=-0.5, 0, 0,-1, 0, 0;0.5, 0, 0,1, 0, 0;0, 0, 0.4,0, 0, -1;0, 0, 0.5,0, 0, 1;0, 0.5, 0,0, 1, 0
rail3_volumes=-0.5, 0, 0.5,-.7071, 0, .7071;0.5, 0, -0.5,0.7071, 0, -0.7071;-0.1, 0, -0.1,-.7071, 0, -.7071;0.1, 0, 0.1,.7071, 0, .7071;0, 0.5, 0,0, 1, 0
rail4_volumes=-0.1, 0, 0.1,-.7071, 0, .7071;0.1, 0, -0.1,0.7071, 0, -0.7071;-0.5, 0, -0.5,-.7071, 0, -.7071;0.5, 0, 0.5,.7071, 0, .7071;0, 0.5, 0,0, 1, 0
rail5_volumes=-0.1, 0, 0.1,-.7071, 0, .7071;0.1, 0, -0.1,0.7071, 0, -0.7071;-0.5, 0, -0.5,-.7071, 0, -.7071;0.5, 0, 0.5,.7071, 0, .7071;0, 0.5, 0,0, 1, 0
qp_volumes=-0.5,0,0,-1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,1,0,0,1,0;0,0,0,0,-1,0;0.190,0.048,0.000,0.309,0.951,0.000/-0.5,0,0,-1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,1,0,0,1,0;0,0,0,0,-1,0;-0.080,0.189,0.000,0.588,0.809,0.000/-0.5,0,0,-1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,1,0,0,1,0;0,0,0,0,-1,0;-0.295,0.408,0.000,0.809,0.588,0.000/-0.5,0,0,-1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,1,0,0,1,0;0,0,0,0,-1,0;-0.433,0.684,0.000,0.951,0.309,0.000
rail6_volumes=0, 0, 0,-1, 0, 0;0.5, 0, 0,1, 0, 0;0, 0, -0.1,0, 0, -1;0, 0, 0.1,0, 0, 1;0, 0.5, 0,0, 1, 0/-0.1, 0, 0.1,-.7071, 0, .7071;0.1, 0, -0.1,0.7071, 0, -0.7071;-0.5, 0, -0.5,-.7071, 0, -.7071;0, 0, 0,.7071, 0, .7071;0, 0.5, 0,0, 1, 0
rail7_volumes=-0.5, 0, 0,-1, 0, 0;0, 0, 0,1, 0, 0;0, 0, -0.1,0, 0, -1;0, 0, 0.1,0, 0, 1;0, 0.5, 0,0, 1, 0/-0.1, 0, 0.1,-.7071, 0, .7071;0.1, 0, -0.1,0.7071, 0, -0.7071;0, 0, 0,-.7071, 0, -.7071;0.5, 0, 0.5,.7071, 0, .7071;0, 0.5, 0,0, 1, 0
stair_volumes=-0.5,0,0,-1,0,0;0.5,0,0,1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,0.25,0,0,1,0/-0.5,0,0,-1,0,0;0,0,0,1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,0.5,0,0,1,0
stairrail_volumes=-0.5,0,0,-1,0,0;0.5,0,0,1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,0.25,0,0,1,0/-0.5,0,0,-1,0,0;0,0,0,1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,0.5,0,0,1,0/-0.5, 0, 0,-1, 0, 0;0.5, 0, 0,1, 0, 0;0, 0, -0.1,0, 0, -1;0, 0, 0.1,0, 0, 1;0, 0.75, 0,0.4472,0.8944,0
barrier_volumes=0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,0,0,0,-1,0;0,0.5,0,0,1,0;0.412,0.037,0.000,0.707,0.707,0.000;-0.412,0.037,0.000,-0.707,0.707,0.000/0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,0,0,0,-1,0;0,0.5,0,0,1,0;0.375,0.125,0.000,1.000,0.000,0.000;-0.375,0.125,0.000,-1.000,0.000,0.000
barrier2_volumes=-0.5,0,0,-1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,0.5,0,0,1,0;0,0,0,0,-1,0;-0.235,0.066,0.000,0.500,0.866,0.000/-0.5,0,0,-1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,0.5,0,0,1,0;0,0,0,0,-1,0;-0.407,0.245,0.000,0.866,0.500,0.000
fence_volumes=-0.5, 0, 0,-1, 0, 0;-0.4, 0, 0,1, 0, 0;0, 0, -0.5,0, 0, -1;0, 0, 0.5,0, 0, 1;0, 1, 0,0, 1, 0
]]for n in all(split(vols_str,"\n"))do sname,svols=unpack(split(n,"="))_ENV[sname]={}for n in all(split(svols,"/"))do add(_ENV[sname],parse_volume(n))end end cached_blocks={}for n=.5,15,.5do cached_blocks[n]={}for e in all(block_volumes[1])do add(cached_blocks[n],{pt=v_copy(e.pt),normal=v_copy(e.normal)})end cached_blocks[n][5].pt[2]+=n-.5end block2_volumes=cached_blocks[1]function parse_tile(n)local n,o,l,f,t,i,d,e,a=unpack(split(n,"/"))local n={name=n,s1=o,s2=l,height=f,volumes=_ENV[t],is_block=i=="t",is_qp=d=="t",rails={}}n.prefab=a or nil if(#e>0)for e in all(split(e,";"))do local e,o,l,f,t,i=unpack(split(e,","))add(n.rails,{{e,o,l},{f,t,i}})end
return n end tiles={}tiles_str=[[block/2/2/0.5/block_volumes/t/f/-0.499, 0.499, -0.499,-0.499, 0.499, 0.499;-0.499, 0.499, 0.499,0.499, 0.499, 0.499;0.499, 0.499, 0.499,0.499, 0.499, -0.499;0.499, 0.499, -0.499,-0.499, 0.499, -0.499
ramp1/6/8/0.5/ramp_volumes/f/f/-0.499, 0.499, -0.499,-0.499, 0.499, 0.499;-0.499, 0.499, 0.499,0.499, 0, 0.499;0.499, 0, 0.499,0.499, 0, -0.499;0.499, 0, -0.499,-0.499, 0.499, -0.499
qp/10/12/1/qp_volumes/f/t/-0.499, 0.999, -0.499,-0.499, 0.999, 0.499
rail1/34/34/0.5/rail1_volumes/f/f/-0.499, 0.499, 0,0.499, 0.499, 0
ramp2/38/40/1/ramp2_volumes/f/f/-0.499,0.999,-0.499,-0.499,0.999,0.499;-0.499,0.999,0.499,0.499,0,0.499;0.499,0,0.499,0.499,0,-0.499;0.499,0,-0.499,-0.499,0.999,-0.499
rail2/42/42/0.5/rail2_volumes/f/f/-0.499, 0.499, 0.499,0.499, 0.499, 0.499
rail3/44/44/0.5/rail3_volumes/f/f/0.499, 0.499, -0.499,-0.499, 0.499, 0.499
rail4/46/46/0.5/rail4_volumes/f/f/0.499, 0.499, 0.499,-0.499, 0.499, -0.499
rail5/64/64/0.5/rail5_volumes/f/f/0, 0.499, -0.499,0.499, 0.499, 0
hblock1/4/4/1/hblock1_volumes/f/f/0.499, 0.999, -0.499,-0.499, 0.999, 0.499;-0.499,0.999,0.499,0.499,0.999,0.499;0.499,0.999,0.499,0.499,0.999,-0.499
hblock2/36/36/1/hblock2_volumes/f/f/0.499, 0.999, 0.499,-0.499, 0.999, -0.499;-0.499,0.999,-0.499,-0.499,0.999,0.499;-0.499,0.999,0.499,0.499,0.999,0.499
taxi1/108/108/1/block_volumes/f/f/-0.499, 0.499, -0.499,-0.499, 0.499, 0.499;-0.499, 0.999, 0.499,0.499, 0.499, 0.499;0.499, 0.499, 0.499,0.499, 0.499, -0.499;0.499, 0.499, -0.499,-0.499, 0.999, -0.499/t
taxi2/110/110/1/block_volumes/f/f/-0.499, 0.499, -0.499,-0.499, 0.499, 0.499;-0.499, 0.499, 0.499,0.499, 0.999, 0.499;0.499, 0.499, 0.499,0.499, 0.499, -0.499;0.499, 0.999, -0.499,-0.499, 0.499, -0.499/t
floor1/114/114/0/empty_volumes/f/f//t
floor2/116/116/0/empty_volumes/f/f//t
floor3/118/118/0/empty_volumes/f/f//t
floor4/98/100/0/empty_volumes/f/f//t
floor5/102/102/0/empty_volumes/f/f//t
stair/66/68/0.5/stair_volumes/f/f/
stairrail/70/72/1/stairrail_volumes/f/f/-0.499, 0.999, 0,0.499, 0.499, 0
rail6/74/76/0.5/rail6_volumes/f/f/0.499, 0.499, 0,0, 0.499, 0;0,0.499,0,-0.499,0.499,-0.499
rail7/64/78/0.5/rail7_volumes/f/f/-0.499, 0.499, 0,0, 0.499, 0;0,0.499,0,0.499,0.499,0.499
module/128/128/1/block2_volumes/t/f/-0.499, 0.999, -0.499,-0.499, 0.999, 0.499;-0.499, 0.999, 0.499,0.499, 0.999, 0.499;0.499, 0.999, 0.499,0.499, 0.999, -0.499;0.499, 0.999, -0.499,-0.499, 0.999, -0.499
barrier/132/132/0.5/barrier_volumes/f/f/0, 0.499, -0.499,0, 0.499, 0.499
fence/128/130/1/fence_volumes/f/f/-0.499, 0.999, -0.499,-0.499, 0.999, 0.499
floor6/104/104/0/empty_volumes/f/f//t
floor7/120/120/0/empty_volumes/f/f//t
door/134/136/1/empty_volumes/f/f/
barrier2/136/138/0.5/barrier2_volumes/f/t/-.5, 0.499, -0.499,-.5, 0.499, 0.499
floor8/96/96/0/empty_volumes/f/f//t
cop1/140/140/1/block_volumes/f/f/-0.499, 0.499, -0.499,-0.499, 0.499, 0.499;-0.499, 0.999, 0.499,0.499, 0.499, 0.499;0.499, 0.499, 0.499,0.499, 0.499, -0.499;0.499, 0.499, -0.499,-0.499, 0.999, -0.499/t
cop2/142/142/1/block_volumes/f/f/-0.499, 0.499, -0.499,-0.499, 0.499, 0.499;-0.499, 0.499, 0.499,0.499, 0.999, 0.499;0.499, 0.499, 0.499,0.499, 0.499, -0.499;0.499, 0.999, -0.499,-0.499, 0.499, -0.499/t
floor9/106/106/0/empty_volumes/f/f//t
floor10/122/122/0/empty_volumes/f/f//t
floor11/112/112/0/empty_volumes/f/f//t]]for n in all(split(tiles_str,"\n"))do add(tiles,parse_tile(n))end input_list={}trick_inputs={}tricks={}tricks_str=split([[chickflip/⬅️🅾️/8/100/f/f/0,0,360//
hospital flip/⬅️⬇️🅾️/12/250/f/f/0,0,180;0,180,0//
underflip/➡️⬇️🅾️/12/250/f/f/90,0,0;270,0,360//
heelflap/➡️🅾️/12/150/f/f/0,0,-360//
shuvit/⬆️🅾️/6/100/f/f/-180,0,0//
360 shuv/⬆️⬇️🅾️/11/250/f/f/-360,0,0//
tre flip/⬇️🅾️/15/200/f/f/-360,0,360//
beak grab/⬆️⬆️🅾️/15/300/f/f//0,45,0/209
rocket air/⬆️⬆️⬆️🅾️/25/300/f/f//0,15,0/199
tail grab/⬇️⬇️🅾️/15/300/f/f//0,-45,0/210
crossbone/➡️➡️🅾️/13/270/f/f//45,0,0/225
judo air/⬅️⬅️🅾️/15/300/f/f//-45,0,0/224
chickflip cancel/⬅️➡️🅾️/20/300/f/f/0,0,270;0,0,-270//
ufo bird/⬅️⬆️➡️🅾️/31/1200/f/f/720,0,0//228
egg/⬅️⬇️➡️⬆️🅾️/35/1200/f/f/0,0,0//229
grind///100/t/f//90,0,0/208
manual/⬆️⬇️//40/f/t//0,30,0/208
headstand/⬆️⬆️⬇️//70/f/t//0,30,0/228
casper slide/⬇️⬇️⬆️//60/f/t//0,30,180/208
nose manual/⬇️⬆️//50/f/t//0,-30,0/208
taxi gap///200/f/f////
halfpipe gap///200/f/f////
halfpipe///0/f/f////
module gap 1///400/f/f////
module gap 2///400/f/f////
eight stair///200/f/f////
central rail///150/f/f////
curb stair///300/f/f////
pipe transfer///200/f/f////
caution tape to taxi///300/f/f////
180///180/f/f////
360///360/f/f////
540///540/f/f////
720///720/f/f////
900///900/f/f////
1080///1080/f/f////
]],"\n")function draw_trick_list()local n=split([[ᶜb❎ ᶜ6ollie
ᶜ8🅾️ ᶜ6grind
manuals-
⬆️⬇️ ᶜ6manual
⬇️⬆️ ᶜ6nose manual
flip trix-
⬆️ᶜ8🅾️ ᶜ6shuv it
⬅️ᶜ8🅾️ ᶜ6chickflip
➡️ᶜ8🅾️ ᶜ6heelflap
⬇️ᶜ8🅾️ ᶜ6tre flip
grabs-
⬆️⬆️ᶜ8🅾️ ᶜ6beak grab
⬇️⬇️ᶜ8🅾️ ᶜ6tail grab
magic-
⬅️⬆️➡️ᶜ8🅾️ ᶜ6ufo bird
... and many more??
]],"\n")rectfill(0,0,127,127,0)for n,e in ipairs(n)do gprint(e,2,n*8-8,7)end grungebutton("🅾️ back",95,8,7,8)end function parse_trick(n)local e,t,i,d,o,l,f,n,a=unpack(split(n,"/"))e=tostr(e)n=split(n,",")f=split(f,";")spins={}for n in all(f)do if(#n>0)add(spins,split(n,","))
end if(#spins==0)spins=nil
if(#n~=3)n=nil
o=o=="t"l=l=="t"if(#t>0)trick_inputs[t]=e
tricks[e]={spins=spins,holdspin=n,anim=tonum(a),time=i,score=d*.00002,is_manual=l,is_grind=o}end for n=1,#tricks_str-1do parse_trick(tricks_str[n])end function add_input(n)add(input_list,{key=n,time=time})end function update_inputs()for n,e in ipairs(split"⬅️,➡️,⬆️,⬇️,🅾️,❎")do if(btnp(n-1))add_input(e)
end while#input_list>0and time>input_list[1].time+11do deli(input_list,1)end end function try_get_trick()for e=min(#input_list,5),1,-1do local n=""for e=#input_list-e+1,#input_list do n..=input_list[e].key end if(trick_inputs[n])local n=trick_inputs[n]input_list={}return n
end return nil end function score_str(n)return tostr(n,2)end function draw_combo()if#combo>0then if(#combo>1)local n="X"..#combo.." = "..score_str(current_combo_score)sprint(n,64-#n*2,100,12)
local n=combo[#combo]local n=n.trick.." "..score_str(n.final_score)sprint(n,64-#n*2,109-latest_trick_time/4,7)elseif combo_end_time>0then local n if(#last_combo>1)n=#last_combo-1 .." trick combo + "..last_combo[#last_combo].trick else n=last_combo[1].trick
sprint(n,64-#n*2,109+(60-combo_end_time)/15,last_trick_fall and 8or 9)local n=score_str(last_combo_score)sprint("⁶w⁶t"..n,64-#n*4,92+(60-combo_end_time)/15,last_trick_fall and 8or 10)end end function add_combo(n)local e=tricks[n].score add(combo,{trick=n,score=e,duration=1,final_score=e})latest_trick_time=10skatesnd(52)end function increment_combo()combo[#combo].duration+=.03333end function update_combo()latest_trick_time=max(latest_trick_time-1,0)combo_end_time=max(combo_end_time-1,0)current_combo_score=0for n=1,#combo do if(n==#combo)local e=combo[#combo]combo[n].final_score=e.score*e.duration
current_combo_score+=combo[n].final_score*#combo end end function end_combo(n)n=n or false if#combo>0then if(not n)score+=current_combo_score
last_trick_fall=n last_combo=combo last_combo_score=current_combo_score combo={}combo_end_time=60end end cached_prefabs={}function plane_segment(n,o,e)local o=v_sub(v_add(o,e),n.pt)local l=v_dot(o,n.normal)if l<0then local e,n=abs(v_dot(e,n.normal)),abs(v_dot(o,n.normal))local n=1-n/e if(n>=0)return n
end return nil end function check_inside(e,n)for n in all(n)do if(v_dot(v_sub(e,n.pt),n.normal)>0)return false
end return true end function find_first_collision(n,l,o)local f,t,e,i=nil,nil,16959,nil for o in all(o)do local o,d,c=unpack(o)local d=v_sub(n,d)for a in all(o)do local n=plane_segment(a,d,l)if n~=nil and n<e then local l=v_add(d,v_mul(l,n+.001))if(check_inside(l,o))e=n t=a f=o i=c
end end end return f,t,e,i end function rotate(n,e,o)if(o)n={-n[1],n[2],n[3]}
if(e)n={n[3],n[2],n[1]}
return n end function prepare_prefab_volume(l,n,e)local o={}for l in all(l)do local n={normal=rotate(l.normal,n,e),pt=rotate(l.pt,n,e)}add(o,n)end return o end function prepare_collision_volumes(n)local o={}for n in all(n)do local e=n.tiletype if(n.elev>0)local e,l={n.x+.5,0,n.z+.5},cached_blocks[n.elev]add(o,{l,e,n})
for l=1,#e.volumes do local f,t,l={n.x+.5,n.elev,n.z+.5},e.volumes[l],e.name.."_"..l.."_"..(n.fliph and 1or 0)..(n.flipv and 1or 0)local e=cached_prefabs[l]if(not e)e=prepare_prefab_volume(t,n.fliph,n.flipv)cached_prefabs[l]=e
add(o,{e,f,n})end end return o end function find_ground(n,e)local o=get_cell(n)if o then local l={0,-n[2],0}e=e or prepare_collision_volumes{o}local f,e,o=find_first_collision(n,l,e)if(e)return v_add(n,v_mul(l,o))
end return{n[1],0,n[3]}end function collide_point_volumes(o,n,i)if(#i==0)return v_add(o,n),n
local n,e,l,d,f,t=v_copy(o),v_copy(n),false,0,nil,nil while not l do local a,o,r,o,i,c=v_mag(e),v_copy(n),find_first_collision(n,e,i)if o and d<20then t=c f=o local f=i-.001/a local t=v_mul(e,f)n=v_add(n,t)local f,n=v_mul(e,1-f),v_norm(v_cross(v_cross(v_norm(e),o.normal),o.normal))local o=v_mag(n)if(o<.9or o>1.1)l=true else local o=v_dot(f,n)e=v_mul(n,o)
d+=1else l=true n=v_add(n,e),f,t end end return n,v_sub(n,o),f,t end function get_rail_t(e,n)return v_dot(v_sub(e,n[1]),n.fwd)end function get_next_rail_pt(e,f,o,n)local e=get_rail_t(e,n)local l=e+o if(v_dot(f,n.fwd)<0)l=e-o
return v_add(n[1],v_mul(n.fwd,l)),e,n.len end STEP,FRICTION,DEG2RAD,BASEMAXSPEED,MAXMAXSPEED=.2,.0012,.01745,.115,.195function make_skater()local n={pos=split(level_start),depth=0,vel={0,0,0},fwd=v_norm{0,0,1},flat_fwd=v_norm{0,0,1},jump_charge=0,jumped=false,airborne_frames=0,height=.125,airborne=false,floor_normal={0,1,0},grind_fwd=0,grind_speed=0,max_speed=.125,char_y=0,char_yv=0,current_trick_t=0,fall_timer=0,fall_time=0,in_manual=false,rotvel=0,spin_counter=0,balance=0,balance_volatility=0,balance_vel=0,draw=function(n)local o,f,e,l=v_copy(n.fwd),n.pos,v_zero(),n.current_trick if l then if(l.spins)local o,n=min(n.current_trick_t/l.time,.999),l.spins local l=o*#n\1+1for o=1,l-1do e=v_add(e,v_mul(n[o],DEG2RAD))end e=v_add(e,v_mul(n[l],o*#n%1*DEG2RAD))
if(l.holdspin)e=v_mul(l.holdspin,min(n.current_trick_t/8,.999)*DEG2RAD)
if(e[1]~=0)local n=atan2(o[1],o[3])o[1]=cos(n+e[1])o[3]=sin(n+e[1])
if(e[2]~=0)o[2]+=sin(e[2])/cos(e[2])o=v_norm(o)
end local t,i=cos(e[3]*2)*.5+1,cos(e[3]+e[2])>0and 0or 8for n=-1,1,.125do local e=v_add(f,v_mul(o,n*.25))if(n==1or n==-1)e[2]+=.125
local n=v2p(e)circfill(n[1],n[2],t,i)end if e[3]~=0then local n=v_mul(o,.25)local n,o=v_add(f,n),v_sub(f,n)local n,o=v2p(n),v2p(o)local l,f,e=(o[1]-n[1])*t/6,(o[2]-n[2])*t/6,e[3]%3.1416if(e<1.5707)line(n[1]+f,n[2]-l,o[1]+f,o[2]-l,i==0and 5or 2)else line(n[1]-f,n[2]+l,o[1]-f,o[2]+l,i==0and 5or 2)
end local t,o,e=nil,false,192if n.fall_timer>0then n.vel=v_zero()local l=1-n.fall_timer/n.fall_time local i=l o=n.fall_vector[1]-n.fall_vector[3]>0if l<.25then i=sin(l*6.2818)e=197+n.fall_timer\2%2elseif l<.5then i=1else i=1-(l-.5)*2o=not o end local e=v_add(f,v_mul(n.fall_vector,i))t=v2p(e)n.shadow.pos=e else t=v2p{f[1],n.char_y,f[3]}o=n.flat_fwd[1]-n.flat_fwd[3]>0if l and l.anim then e=l.anim else e=192+(n.airborne_frames+3)\4if(e>=197)e=195+(e-1)%2
if(e==192and n.pushing)e=211+time\4%6
end end spr(e,t[1]-4,t[2]-8,1,1,o)end,draw_arrow=function(o,n,i)local e,o=o.pos,o.flat_fwd local f,l,t,e=v2p(v_fwd_lateral(e,o,.5,0)),v2p(v_fwd_lateral(e,o,1.5,0)),v2p(v_fwd_lateral(e,o,1.25,.25)),v2p(v_fwd_lateral(e,o,1.25,-.25))line(f[1],f[2]+n,l[1],l[2]+n,i)line(t[1],t[2]+n)line(l[1],l[2]+n,e[1],e[2]+n)end,control=function(n,e,l,t)if(n.grind_line~=nil)n.balance+=e*(n.balance_volatility+1)*-.35n.rotvel=0return
if(n.in_manual)n.balance+=l*(n.balance_volatility+1)*-.35
if(n.fall_timer>0)n.rotvel=0return
local o=n.airborne and.2or.12n.rotvel=mid(n.rotvel+e*.02,-o,o)if(e==0)n.rotvel*=.7
local e=atan2(n.flat_fwd[1],n.flat_fwd[3])local o,f=e+n.rotvel,v_flat(n.vel)local e=v_mag(f)if(e<BASEMAXSPEED)n.max_speed=BASEMAXSPEED else n.max_speed=min(n.max_speed+.0007,MAXMAXSPEED)
n.flat_fwd={cos(o),0,sin(o)}if n.airborne then n.spin_counter+=n.rotvel if(n.current_trick and n.current_trick.is_grind)n.current_trick=nil
if l==1then local e,o={cos(o),n.vel[2],sin(o)},v_dot(n.flat_fwd,f)if(o<n.max_speed)n.vel=v_add(n.vel,v_mul(e,.005))
end else if(t or l>0)e+=e>n.max_speed and FRICTION or.01n.pushing=true else n.pushing=false
if(l==-1)e=max(e-.01,0)
local e,o={cos(o)*e,n.vel[2],sin(o)*e},v_dot(n.flat_fwd,v_norm(f))if v_mag(n.vel)>.1and abs(o)<.6then n:fall()else if not n.in_manual then local e=n.current_trick~=nil and not n.current_trick.is_manual and not n.current_trick.is_grind and n.current_trick_t<n.current_trick.time-2end_combo(e)n.balance_volatility=0n.balance=0if(e)n:fall()
end if v_mag(e)>.01then if(o<0)n.flat_fwd=v_mul(n.flat_fwd,-1)e[1]=-e[1]e[3]=-e[3]
end n.vel=e end end if n.current_qp then if(n.qp_target==nil)n.qp_target=v_copy(n.pos)
if(l==1)n.qp_target=v_fwd_lateral(n.qp_target,n.flat_fwd,.08,0)
end end,fall=function(n)n.fall_vector=v_mul(v_flat(n.vel),15)n.fall_time=30n.fall_timer=n.fall_time n.vel=v_zero()n.current_trick=nil n.grind_line=nil n.balance_volatility=0n.balance=0n.in_manual=false end_combo(true)skatesnd(53)end,update=function(n)if(n.fall_timer>0)n.fall_timer-=1return
if n.grind_line~=nil then increment_combo()n:push_balance()if(n.grind_line==nil)return
n.grind_speed+=n.grind_fwd[2]*-.01local l,e,o=get_next_rail_pt(n.pos,n.grind_fwd,n.grind_speed,n.grind_line)n.fwd=n.grind_fwd n.vel=v_mul(n.fwd,n.grind_speed)if(n.grind_speed<.005)n.grind_line=nil
if(e>o or e<0)n.grind_line=nil n:lock_grind(0)
skatesnd(49,8)end if(n.grind_line==nil and n.current_trick and n.current_trick.is_grind)n.current_trick=nil
local e=v_flat(n.vel)local o=v_mag_sq(e)if not n.airborne and not n.grind_line then if(o>FRICTION)n.fwd=v_norm(n.vel)local o=v_mag(e)e=v_mul(v_norm(e),o-FRICTION)n.vel={e[1],n.vel[2],e[3]}skatesnd(48,7)else n.vel={0,n.vel[2],0}
end n:update_qp()local e=prepare_collision_volumes(get_cells_within(n.pos,.5))add(e,ground_volume)local o,l=-.014,n.airborne_frames n.airborne=true if(n.grind_line~=nil)n:finish_spin()o,n.airborne,n.airborne_frames,n.jumped=0,false,0,false
local f=v_copy(n.pos)n.pos,n.vel,collision_plane,hit_cell=collide_point_volumes(n.pos,v_add(n.vel,{0,o,0}),e)n.pos[1]=mid(n.pos[1],minx+.1,maxx+.9)n.pos[3]=mid(n.pos[3],minz+.1,maxz+.9)n.vel=v_sub(n.pos,f)if collision_plane~=nil then if(not hit_cell)hit_cell=get_cell(n.pos)
if(hit_cell and hit_cell.tiletype.is_qp)n.current_qp=hit_cell
if collision_plane.normal[2]>.5then if n.in_manual then if(n.current_trick and n.current_trick.is_manual)increment_combo()else add_combo(n.in_manual)n.current_trick=tricks[n.in_manual]n.current_trick_t=0
n:push_balance()end n:finish_spin()if l>0then if n.last_ground_cell and hit_cell then local n,e=n.last_ground_cell.special,hit_cell.special if n and e then if(n>e)n,e=e,n
local n=level_specials[level_index][n..">"..e]if(n)add_combo(n)
end end skatesnd(50)end n.airborne,n.airborne_frames,n.jumped,n.last_ground_cell,n.qp_target=false,0,false,hit_cell,nil end end n.shadow.pos=find_ground(n.pos,e)n.char_yv-=.02n.char_y=n.char_y+n.char_yv if n.char_y<n.pos[2]then n.char_yv=-n.char_yv*.4n.char_y=n.pos[2]elseif n.char_y>n.pos[2]+.5then n.char_y=n.pos[2]+.5n.char_yv=n.vel[2]end if(n.airborne)n.airborne_frames+=1
if(n.airborne_frames==3)n.in_manual=false
n:update_trick()local e,o=0,get_cell(n.pos)if(o)e=o.ent.center[2]+.1
n.depth=n.pos[1]\1+e+n.pos[3]\1+1n.shadow.depth=n.depth-.01end,push_balance=function(n)n.balance_volatility+=.02if(abs(n.balance)>7)n:fall()return
n.balance+=n.balance_vel*(n.balance_volatility+1)*.05if(time%(30/n.balance_volatility)\1==0or n.balance_vel==0)n.balance_vel=sgn(rnd()-.5)
end,finish_spin=function(n)local e=abs(n.spin_counter/3.1416)\1*180if(e>0)add_combo(tostr(min(e,1080)))
n.spin_counter=0end,update_qp=function(n)if n.qp_target then n.qp_target[2]=n.pos[2]if(v_mag(v_sub(n.qp_target,n.pos))>.5)n.current_qp=nil
end local e=get_cell(n.pos)if(not e or not e.tiletype.is_qp)n.current_qp=false
if(n.current_qp)if e.fliph and e.flipv then n.vel[3]=min(n.vel[3],e.z+.95-n.pos[3])elseif e.fliph and not e.flipv then n.vel[3]=max(n.vel[3],e.z+.05-n.pos[3])elseif not e.fliph and e.flipv then n.vel[1]=min(n.vel[1],e.x+.95-n.pos[1])else n.vel[1]=max(n.vel[1],e.x+.05-n.pos[1])end
end,update_trick=function(n)if(n.current_trick)n.current_trick_t+=1if n.current_trick.is_manual and not n.in_manual then n.current_trick=nil elseif not n.current_trick.is_manual and not n.current_trick.is_grind and n.current_trick_t>n.current_trick.time then n.current_trick=nil end
end,jump=function(n)if(not n.airborne or n.airborne_frames<5and not n.jumped)skatesnd(51)n.airborne=true n.jumped=true n.vel[2]+=mid(n.jump_charge,6,10)/60n.jump_charge=0n.grind_line=nil n.char_yv=n.vel[2]*1.125
n.jump_charge=0end,trick=function(n)if n.airborne and n.current_trick==nil then if not n.grind_line then local e=try_get_trick()if e then if(tricks[e].is_manual)n.in_manual=e else n.current_trick=tricks[e]n.current_trick_t=0add_combo(e)n.in_manual=false
end end end end,hold_grind=function(n)if(n.airborne and n.current_trick==nil)n:lock_grind(.03)
end,lock_grind=function(n,o)if(n.grind_line)return
local e,l,f=n:get_best_grind()n.grind_line=e if n.grind_line then n.airborne=false n.grind_fwd=v_mul(v_norm(v_sub(e[2],e[1])),l)n.grind_speed=v_mag(v_flat(n.vel))+o local e=v_flat(n.fwd)n.flat_fwd=n.grind_fwd local l,e=get_next_rail_pt(n.pos,e,n.grind_speed,n.grind_line),v_cross(v_cross(n.grind_fwd,{0,1,0}),n.grind_fwd)e=v_mul(e,.125)n.pos=v_add(l,e)if(o>0)add_combo"grind"
n.current_trick=tricks["grind"]end end,get_best_grind=function(n)local f,t,l,i,n=n.grind_line,.25,v_add(n.pos,n.vel),1,v_flat(n.vel)local a=v_norm(n)if v_mag(n)>.03then for d in all(get_cells_within(l,1))do for n in all(d.rails)do local e,o=get_rail_t(l,n)if e<0then o=n[1]elseif e>1then o=n[2]else o=v_add(n[1],v_mul(n.fwd,e))end local l,o=v_mag(v_sub(l,o)),0if l<.45and e>0and e<n.len then local e=v_dot(n.fwd,a)o=abs(e)if(o>t)t=o f=n best_cell=d i=sign(e)
end end end end return f,i,best_cell end}n.shadow={pos=v_zero(),depth=0,height=0,draw=function(n)local n=v2p(n.pos)ovalfill(n[1]-2.5,n[2]-1,n[1]+2.5,n[2]+1,5)end}return n end level_goals={{},{},{}}goals_str=[[1/score 3,000◆/score/.0458
1/ollie the taxi gap/gap/taxi gap
1/score 10,000◆/score/0.1526
1/chickflip the halfpipe gap/gap/halfpipe gap/chickflip
1/score 1,000◆ <= 10-combo/combo/.0153/10
1/land a 360゜ on the halfpipe/gap/halfpipe/360
1/score 3,000◆ <= 10-combo/combo/.0458/10
1/score 3,000◆ <= 5-combo/combo/.0458/5
2/score 10,000◆/score/.1526
2/score 20,000◆/score/.3052
2/score 2,000◆ <= 10-combo/combo/.0305/10
2/score 5,000◆ <= 10-combo/combo/.0763/10
2/beak grab the curb stair/gap/curb stair/beak grab
2/tail grab the pipe transfer/gap/pipe transfer/tail grab
2/score 5,000◆ <= 5-combo/combo/.1373/5
2/score 3,000◆ <= 2-combo/combo/.0458/2
3/score 15,000◆/score/.2289
3/tre flip the eight stair/gap/eight stair/tre flip
3/score 30,000◆/score/.4578
3/score 7,500◆ <= 5-combo/combo/.1144/5
3/combo both module gaps/gap/module gap 2/module gap 1
3/ufo bird the pipe transfer/gap/pipe transfer/ufo bird
3/score 12,500◆ <= 5-combo/combo/.1907/5
3/score 75,000◆/score/1.1444
]]for n in all(split(goals_str,"\n"))do v=split(n,"/")add(level_goals[v[1]],{name=v[2],type=v[3],param=v[4],param2=v[5]})end function gi(n)return level_index*10+n-11end function is_goal_complete(n)return dget(gi(n))~=0end function update_goals()for e=1,#level_goals[level_index]do local n=level_goals[level_index][e]if not is_goal_complete(e)then complete=false if(n.type=="score")complete=score>=n.param
if#last_combo>0and not last_trick_fall then if n.type=="combo"then complete=#last_combo<=n.param2 and last_combo_score>n.param elseif n.type=="gap"and#last_combo>0then local e=n.param2==nil for o in all(last_combo)do if(o.trick==tostr(n.param2))e=true
if(o.trick==tostr(n.param))complete=true
end if(not e)complete=false
end end if(complete)dset(gi(e),1)goal_complete_timer=90goal_completed=n.name skatesnd(55)
end end end goal_complete_timer=0function draw_goals()if(goal_complete_timer>0)goal_complete_timer-=1local n,e=64-#goal_completed*2,64+#goal_completed*2grungeline(n-4,e,14,21,10)gprint(goal_completed,64-#goal_completed*2,16,0,15)local o=mid((125-goal_complete_timer*2)/45,0,1)line(n-3,17+pr(n,0),n-3+(e-n)*o,17+pr(e,1)*3*o,0)
end MUSICS=split"0,11,24"function game_init()load(level_index)fix_grinds()skater=make_skater()add(all_entities,skater)add(all_entities,skater.shadow)scroll={0,0}score=0level_specials={{["1>2"]="halfpipe gap",["3>4"]="taxi gap",["5>5"]="halfpipe"},{["1>2"]="curb stair",["3>4"]="pipe transfer",["5>6"]="caution tape to taxi"},{["1>6"]="module gap 1",["2>3"]="module gap 2",["4>5"]="eight stair",["7>8"]="pipe transfer"}}menuitem(769,"trick list",function()game_mode="tricks"end)menuitem(770,"goals",function()game_mode="goals"end)menuitem(771,"level select",function()transition()set_state"select"end)time=0gametime=0goal_complete_timer=0last_combo={}combo={}latest_trick_time=0combo_end_time=0current_combo_score=0last_combo_score=0timeup=false music(rnd(MUSICS))end function game_update()time=min(time+1,32000)if game_mode~=nil then if(btnp(4))game_mode=nil
return end if(gametime<3599or#combo==0)gametime=min(gametime+1,32000)
local n,e=0,0if(btn(0))n+=1
if(btn(1))n+=-1
if(n==0)if btn(2)then e=1elseif btn(3)then e=-1end
if not timeup then skater:control(n,e,btn(5))if(btn(5))skater.jump_charge+=1
if(not btn(5)and skater.jump_charge>0)skater:jump()
if btnp(4)then elseif btn(4)then skater:hold_grind()end skater:trick()local n=v2p(skater.pos)if(abs(n[1]-64)>6)scroll[1]=(64-n[1])*.1+scroll[1]*.9
if(abs(n[2]-64)>6)scroll[2]=(64-n[2])*.1+scroll[2]*.9
if(gametime>3300and gametime%30==0)skatesnd(gametime==3600and 54or 56)
else if gametime>3660then if(btnp(4))transition()set_state"select"
if(btnp(5))transition()set_state"game"
end end update_inputs()skater:update()update_combo()update_goals()end function game_draw()cls(15)camera(-scroll[1],-scroll[2])render_iso_entities(26,true)local n=v2p(skater.pos)if(skater.grind_line)spr(240,n[1]-8,n[2]-16,2,1)spr(242,n[1]+mid(skater.balance,-6,6)-1.5,n[2]-16,1,1)
if(skater.in_manual)spr(227,n[1]+6,n[2]-9,1,2)spr(226,n[1]+6,n[2]-3+mid(skater.balance,-6,6),1,1)
skater:draw_arrow(1,12)skater:draw_arrow(0,7)camera()if gametime<3600then draw_combo()local n=120-gametime\30local n=n\60 ..":"..(n%60<10and"0"..n%60or n%60)sprint(n,64-#n,4,gametime<2700and 7or 8)sprint("◆"..score_str(score),4,4,7)else timeup=true music(-1)camera(0,p8cos(mid((gametime-3600)/30,0,.5))*64+48)print("⁶w⁶ttime's up!",24,-11,0)print("⁶w⁶ttime's up!",24,-12,7)rectfill(2,2,125,68,0)draw_goal_list(4,7)local n=score_str(score)sprint("◆"..n,116-#n*4,4,7)camera()if(gametime>3660)grungebutton("❎ play again",64,100,7,11)grungebutton("🅾️ level select",64,115,7,8)
end draw_goals()if game_mode=="tricks"then draw_trick_list()elseif game_mode=="goals"then rectfill(2,2,125,69,0)draw_goal_list(4,7)grungebutton("🅾️ back",64,80,7,8)end pal(split(LEVEL_PALETTE),1)end scroll={0,0}function select_init()time=0music(39)end function select_update()time+=1local n=level_index if btnp(0)then level_index-=1elseif btnp(1)then level_index+=1end level_index=mid(level_index,1,3)if(level_index~=n or time==1)skatesnd(57)load(level_index)presort_cells()fix_brights()level_time=0
if(btn(5)and level_time>4)transition()set_state"game"
local n=v2p{minx+7,0,minz+(sin(time/90)+2.5)*(maxz-minz)*.2}scroll[1]=64-n[1]\2*2scroll[2]=64-n[2]level_time+=1end function draw_goal_list(e,o,n)local f=0n=n or 999local l=level_goals[level_index]for n=1,min(#l,n\2)do local t=is_goal_complete(n)local l=gprint(l[n].name,e,n*7+o-1,t and 15or 7)if(t)line(e+1,n*7+o+1+pr(n,0)*3,e+l,n*7+o+pr(n,1)*3,6)f+=1
end gprint(f.."/"..#l,e,o-3,6)end function select_draw()cls(1)rectfill(0,0,127,64,15)camera(-scroll[1],-scroll[2]+32)render_iso_entities(20,false)camera()pal(2,1)for n=-1,8do for e=8,12do spr(32,n*8+e*8,e*4-n*4+25,2,2)end end for n=-6,-1do for e=-1,12do spr(32,n*8+e*8,e*4-n*4+25,2,2)end end rectfill(0,64,127,127,1)pal()line(63,64,-1,32,7)line(64,64,129,32,7)draw_goal_list(1,63,level_time)grungebutton("❎ play",64,20,7,11)local n="⁶w⁶t"..level_name local e=print(n,0,-20)print(n,65-e\2,4,0)print(n,64-e\2,3,7)local n=time\10%2==0and 7or 11if(level_index>1)sprint("◀",8,6,n)
if(level_index<3)sprint("▶",112,6,n)
pal(split(LEVEL_PALETTE),1)end map={}isopals={{split"1,5,3,4,5,6,15,8,9,10,11,12,13,14,6,0",split"5,13,3,4,1,13,15,8,9,10,11,12,5,14,6,0"},{split"1,5,3,4,5,6,15,8,9,10,11,12,13,14,6,0",split"5,13,3,4,1,13,15,8,9,10,11,12,5,14,6,0"}}function isospr(a,c,e,o,n,l,f,r,u,h,s,t)n=n or 0local e=v2p(e)local t,i,d=e[1]-8,e[2]-o*8-n*8,e[2]+4-n*8if(not s)pal(isopals[f and 2or 1][l and 2or 1])
local f=f and c or a spr(f,t,i,2,o+1,l)pal()for n in all(h)do spr(n,t,i,2,1)end if n>0then local n=8*n if(r)local o=e[1]-8for e=0,7do local o,e=o+e,d+e\2line(o,e+1,o,e+n,5)end
if(u)local o=e[1]-8for e=8,15do local o,e=o+e,d+8-(e+2)\2line(o,e+1,o,e+n,1)end
end end function make_cell(n,e,o,l,f,t)return{tiletype=n,x=e,z=o,elev=l or 0,fliph=f or false,flipv=t or false}end function get_cell(n)local n,e=n[1]\1,n[3]\1if(map[n]and map[n][e])return map[n][e]
end all_entities={}function add_map_tile(n,e,i,f,o,d,l)f=f or 0if(map[n]==nil)map[n]={}
if(map[n][e])local o=map[n][e]del(all_entities,o.ent)map[n][e]=nil
if(not map[n][e])local t=tiles[i]local o=make_cell(t,n,e,f,o,d)o.special=l and l>0and l local l={pos={n,0,e},center={n+.5,0,e+.5},depth=0,cell=o,height=f+.5+t.height,brights={},draw=function(l)local i,f=not(map[n+1]and map[n+1][e]and map[n+1][e].elev>=f),not(map[n]and map[n][e+1]and map[n][e+1].elev>=f)isospr(t.s1,t.s2,{n,0,e},t.height,o.elev,o.fliph,o.flipv,i,f,l.brights,t.prefab)end}l.depth=get_depth(l)o.ent=l o.index=i add(all_entities,l)map[n][e]=l.cell l.cell.rails={}l.depth=axis local n={n+.5,f,e+.5}for e in all(t.rails)do local f,e=rotate(e[1],o.fliph,o.flipv),rotate(e[2],o.fliph,o.flipv)local o=v_sub(e,f)add(l.cell.rails,{v_add(f,n),v_add(e,n),fwd=v_norm(o),len=v_mag(o)})end return o
end function get_depth(n)return n.center[1]+n.center[2]+n.center[3]end function presort_cells()for n in all(all_entities)do if(n.cell)n.depth=get_depth(n)else n.depth=0
end local n={}for e in all(all_entities)do insert_cmp(n,e,function(n,e)return n.depth>e.depth end)end all_entities=n end function render_iso_entities(n,e)local o=p2v{64,64}local o,l=o[1]\1,o[3]\1local o,f,l,t=o-n\2,o+n\2,l-n\2,l+n\2for e=o,f do for n=l,t do if(n%2==0and(e<minx or e>maxx or n<minz-1or n>=maxz))spr(112,e*-8+n*8+64,e*4+n*4+68,2,1)
end end if(e)del(all_entities,skater)del(all_entities,skater.shadow)insert_cmp(all_entities,skater,function(n,e)return n.depth>e.depth end)insert_cmp(all_entities,skater.shadow,function(n,e)return n.depth>e.depth end)
for n in all(all_entities)do if(not n.cell or n.cell.x>=o and n.cell.z>=l and n.cell.x<=f and n.cell.z<=t)n:draw()
end if(e)fillp(42405.75)skater:draw()fillp()
end function fix_brights()for e,n in pairs(map)do for o,n in pairs(n)do n.ent.brights={}if n.tiletype.is_block then local l,e=get_cell{e,0,o-1},get_cell{e-1,0,o}if(not l or l.ent.height<=n.ent.height-.1)add(n.ent.brights,200)
if(not e or e.ent.height<=n.ent.height-.1)add(n.ent.brights,201)
end if(n.tiletype.name=="hblock1")add(n.ent.brights,203)
end end end function fix_grinds()for n,e in pairs(map)do for e,l in pairs(e)do l.prepared_planes=nil volumes=prepare_collision_volumes(get_cells_within({n+.5,0,e+.5},1))add(volumes,ground_volume)for e in all(l.rails)do local n,o=v_mul(v_add(e[1],e[2]),.5),v_mul(e.fwd,.25)local i,f,t={n[1]+o[3],n[2]-.125,n[3]-o[1]},false,false for n in all(volumes)do local n,e=unpack(n)if(check_inside(v_sub(i,e),n))f=true break
end if f then local n={n[1]-o[3],n[2]-.125,n[3]+o[1]}for e in all(volumes)do local e,o=unpack(e)if(check_inside(v_sub(n,o),e))t=true break
end end if(f and t)del(l.rails,e)
end end end presort_cells()fix_brights()end function set_state(n,e)if n=="game"then _update,_draw=game_update,game_draw game_init(e)elseif n=="select"then _update,_draw=select_update,select_draw select_init(e)end end function _init()poke(24412,255)time=0level_index=1end function _draw()time+=1cls(1)palt(2)spr(217,44,10,3,3)spr(220,50,24,4,3)print("code, art:\n- @morganqdev\n\nmusic:\n- maple:\n  https://maple.pet/\n\n- wasiknighit:\n  https://wasiknighit.itch.io/",6,68,split"1,1,5,12,7,7,7,7,7,7"[sin(time/38)*8\1+2])if(time>120)set_state"select"
pal(split"133,2,3,4,140,6,7,8,9,10,11,12,13,14,15,0",1)end
__gfx__
00000000cccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cc000000000000777700000000000000000000000000000fff0000000000000000000000000000006600000000000000000000000000000000000000
00000000c0c0000000007777777700000000000000000000000000ffffff00000000000000000000000000066666000000000000000000000000000000000000
00000000c00c00000077777777777700000000000000000000000fffffffff000000000000000000000000066666660000000000000000000000000000000000
0000000000000000777777777777777777777777777777770000ffffffffffffffffffff00000000000000666666666655000000000000000000000000000000
000000000000000055777777777777115577777777777711000ffffffffffff155ffffffff0000000000006f666666665555000000000000000000cccc000000
00000000000000005555777777771111555577777777111100ffffffffffff115555ffffffff0000000000f6f666666155555500000000000000cc0000cc0000
0000000000000000555555777711111155555577771111110ffffffffffff111555555ffffffff0000000fff6f6f6661555555550000000000cc00000000cc00
000000000000000055555555111111115555555511111111ffffffffffff1111555555551111111100000ffffff6f6615555555517000000cc000000000000cc
00000000000000000055555511111100555555551111111100fffffffff1110000555555111111000000ffffffff6f11555555551777000000cc00000000cc00
0000000000000000000055551111000055555555111111110000ffffff1100000000555511110000000f7fffffffff115555555511f7f7000000cc0000cc0000
000000000000000000000055110000005555555511111111000000fff100000000000055110000000777f7fffffff11155555555111f7f77000000cccc000000
0000000000000000000000000000000055555555111111110000000000000000000000000000000077777f7f7ffff11155555555111111110000000000000000
0000000000000000000000000000000000555555111111000000000000000000000000000000000000777777f7ff110000555555111111000000000000000000
00000000000000000000000000000000000055551111000000000000000000000000000000000000000077777f71000000005555111100000000000000000000
00000000000000000000000000000000000000551100000000000000000000000000000000000000000000777100000000000055110000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000770000000000000fff0000000000000000000000000000000000000000000000000000000000000aa0000000
00000000000000000000000000aa00000000000077770000000000ffffff00000000000000000000000000000000000000000000000000000000000aa0000000
000000000000000000000000aaaa00000000000077777700000000ffffffff000000000000000000000000000000000000000000000000000000000aa0000000
0000000000000000000000aaaa000000000000007777777700000fffffffffff00000000000000000000000000000000aaaaaaaaaaaaaaaa0000000aa0000000
00000022220000000000aaaa1700000000000000777777110000fffffffffff1550000000000000000000077770000aaaaaaaaaaaaaaaaaa0000007aa7000000
00002222222200000000aa751777000000000000777711110000fffffffffff15555f00000000000000077777777aaaa00007775177700000000777aa7770000
002222222222220000777775177777000000000077111111000fffffffffff11555555ff000000000077777777aaaa0000777775177777000077777aa7777700
222222222222222277777777777777770000000011111111000ffffffffff111555555551100000077777777aaaa177777777777777777777777777aa7777777
00222222222222000077777777777700000000001111111100fffffffffff1115555555511110000007777aaaa75170000777777777777000077777777777700
0000222222220000000077777777000000000000111111110fffffffffff11115555555511111000000077aa7775000000007777777700000000777777770000
0000002222000000000000777700000000000000111111110fffffffffff11115555555511111110000000777700000000000077770000000000007777000000
000000000000000000000000000000000000000011111111fffffffffff111115555555511111111000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000001111110000ffffffff1111000055555511111100000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000111100000000ffffff1100000000555511110000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000011000000000000fff10000000000005511000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000007777000000000000000000000000000000000a000000000000000000000000000aa000000000000000000000000000000000000000
0000000000aa000000007777777700000000ff00000000000000000000aaa00000000000000000000000000aa00000000000000000aa00000000000000000000
00000000aaaa00000000557777777700007777ff77000000000000000aaa000000000000000000000000000aa000000000000000aaaa00000000000000000000
0000000aaa000000000055557777777777777777ff77000000000000aaa000000000000000000000000000aaa0000000aaaaaaaaaa000000000000aaaaaaaaaa
0000007aa700000000777755557777115577777777ff77000000007aaa0000000000aaaaaaaa00000000aaaa17000000aaaaaaaa170000000000aaaaaaaaaaaa
0000777aa77700007777777755551111555577777777ff77000077aaa77700000000aaaaaaaa00000000aa751777000000007775177700000000aa7517770000
0077777aa77777005577777777551111555555777711171100005aaa17777700007777f517000000007777751777770000777775177777000077777517777700
7777777aa7777777555577777777111155555555111111110000aaa517777777777777751f770000777777777777777777777777777777777777777777777777
007777777777770000555577771111000055555511111100007aaa55557777115577777777ff7700007777777777770000777777777777000077777777777700
0000777777770000000055551111000000005555111100007777a77755551111555577777777ff77000077777777000000007777777700000000777777770000
00000077770000000000005511000000000000551100000055777777775511115555557777111711000000777700000000000077770000000000007777000000
00000000000000000000000000000000000000000000000055557777777711115555555511111111000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000555577771111000055555511111100000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000005555111100000000555511110000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000055110000000000005511000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066aa00000000000000000000
000000ffff0000000000009191000000000000ffff000000000000ffff000000000000ffff000000000000ffff000000000000aa5566aa000000000000000000
00004fffffff00000000919191ff00000000ffffffff00000000ffffffff00000000fffff99f0000000044ffffff000000000aaaaa5566aa0000000000000000
00ffff4fff4fff0000919191ffffff0000ffffffffff910000ffffffffffff0000fffff99ff99f0000ffff44ff44ff000000a11aaaaa55aa0000000000000000
ffffffff4fffffff919191ffffffffffffffffffff919191fffffff44ffffffffffff99ff99fffffffffffff44ffffff000a55511aaaaa990000000000000000
00ffff4fff4fff000091ffffffffff0000ffffff9191910000ffffffffffff0000f99ff99fffff0000ffff44ff44ff0000a55555511aa9550000000000000000
00004fffffff00000000ffffffff00000000ff91919100000000ffffffff00000000f99fffff0000000044ffffff000000a55555555195550000000000000000
000000ffff000000000000ffff0000000000009191000000000000ffff000000000000ffff000000000000ffff0000000a555555555955550000000099000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa9955555591555500000000599a0000
0000004444000000000000ffff000000000000ffff000000000000ffff000000000000ffff000000000000ffff00000022aa995555911599000000005599aa90
00004444444400000000fffffff400000000fffffff400000000fff4ffff00000000ffffffff000000004444444400002224aa99591999990000000055999999
004444444444440000ffff4ff44fff0000fffffff44fff0000fff4fff4ffff0000ffffff77ffff0000f4ffffffff4f00552442aa999911990000000055991199
4444444444444444fffffff44ffffffffffffff444fffffffff4fff4fff4ffffffffff77fffffffffff4ffffffff4fff00554222999161150000000099916115
004444444444440000fff44fffffff0000ffffffffffff0000fff4fff4ffff0000ffffffffffff0000f4ffffffff4f0000005522999116500000000099911650
000044444444000000004fffffff000000004fffffff00000000fff4ffff00000000ffffffff0000000044444444000000000055995115000000000099511500
0000004444000000000000ffff000000000000ffff000000000000ffff000000000000ffff000000000000ffff00000000000000050000000000000055000000
00000000110000000000000000000000000000000000000000000000000000000000000550000000000000000000000000000000887700000000000000000000
00000000101100000000000000000000000000000000000000000000040000000000000555500000000000000000000000000077888c77000000000000000000
0000000011011100000000000000000000005500000000000000000004440000000000066555500000000000000000000000c777778ccc770000000000000000
0000000010101011000000000000000000005555000000000000000004994400000000066665555000000000000000000000c7777777cc770000000000000000
0000000011010101110000000000000000006655550000000000000004999940000000f6666665101000000000000000000c5557777777660000000000000000
000000001010101110110000000000000000666655550000000000000499994000000f6f66666610111000777700000000c55555577766550000000000000000
00000000110101011101110000000000000fff66665100000000000004999940000ffff6f6f66610111117777777000000c55555555655550000000000000000
0000000010101011101010110000000000ffffff6661f700000000000499494000000fffff6f661011111117777777000c555555555c55550000000067000000
0000000011010101110101010000000077777fffff611f7700000000049999400000000ffff6f1101111111f77777777cccc555555c1555500000000567d0000
000000777711101110101011770000000077777ffff111000000007777999940000000000fff100000111111f777770022cccc5555c11577000000005577ddc0
00007777777711011101017177770000000077777f1100000000777777779940000000000000000000001111117700002224cccc5c1c7777000000005577cccc
007777777777771110171711777777000000007771000000007777777777774000000000000000000000001177000000552442cccccc117700000000557711cc
77777777777777771171717177777777000000000000000077777777777777770000000000000000000000000000000000554222ccc161150000000077716115
00777777777777000011171177777700000000000000000000777777777777000000000000000000000000000000000000005522ccc116500000000077711650
00007777777700000000117177770000000000000000000000007777777700000000000000000000000000000000000000000055cc5115000000000077511500
00000077770000000000001177000000000000000000000000000077770000000000000000000000000000000000000000000000050000000000000055000000
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
00077090000077090007700000077000770776670770000007700722000228000000770000000000007700000000000000000000000000000000000000000000
00087000000777700080770077807777778077708777072287770772000277800077000000000000000077000000000000000000000000000000000000000000
00877000008777770777777777777770077777000877777208777678008770907700000000000000000000777777777777777777000000000000000000000000
00009000000790007777977000779700007797000777767807777698087777000000000000000000000000000000000000000000000000000000000000000000
00009900000099000099990000009000000909009909769899097700099067000000000000000000000000000000000000000000000000000000000000000000
00090000000900000000090000090900009000900990077709907770909067700000000000000000000000000000000000000000000000000000000000000000
000228000000000000228007000000000002280000022800000228000002280000022800ee7eeeeeeeeeeeeeeeeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
000277800772280000277867000228000002778000027780000277800002778000027780e7777eeeeeeeeeeeeeeee777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
0007709007727780007769600002778000077090000770900007709000077090000770907777777eeee888888eee777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
77807777007770900077600000087090000870000008700000087000000870000008700077777777eeee888888877777eeeeeeeeeeeeeeeeeeeeeeeeee000eee
777777700008760007777000008770000087700000877000008770000087700000877000eee7777777eee8777788777eeeeeeeeeeeeeeeeeeeeeeeeee00000ee
007797000087766007709000000799000000900000099000000090000000900000009000e777777777888777777877eeeeeeeeeeeeeeeeeeeeeeeee0000000ee
000909000009907777090900000090900000990000909000000099000000990000009900ee7777777778775007778eeeeeeeeeeeeeeeeeeeeeeee000000004ee
009009000090090770090090000900090009090009000000000900000009000000090000eeeee777777777707079eeeeeeeeeeeeeeeeeeeeeee0000000000fee
00228000000000007c00007c008822000090090700000000000000000000000000000000eeee777777777775007999eeeeeeeeeeeeeeeeeee00000000000feee
00277867070228007777777c000820000009907700079000000000000000000000000000eeeeee77777777777799999eeeeeeeeeeeeeeee00000000000ffeeee
00776967777277807c01007c000710000087766000777700000000000000000000000000eeeeeeee777777777798e999eeeeeeeeeeeee00000000000ff2eeeee
007760000777709000000000000710000008770000797900000000000000000000000000eeeeeee7777777777e988ee9eeeeeeeeeee00000000000ff277eeeee
007770090008760000000000000710000767709009979790000000000000000000000000eeeee8877777777eeee999eeeeeeeeeee00000000000ffe27657eeee
0077999000877600000000000007100077627780077779900000000000000000000000008888888777777777eeeeeeeeeeeeeee00000000000ffeeee7567eeee
077900000009966000000000000710007702280000779900000000000000000000000000e8888877777777777e999eeeeeee000000000000ffeeeeeee77eeeee
007900000090096000000000000710000000000000099000000000000000000000000000ee88887777777777799ee9eeeee00000000000ffeeeeeeeeeeeeeeee
000000000000000077700000000710000000000000000000000000000000000000000000e888888e77777ee779eeeeeeeee000000000ffeeeeeeeeeeeeeeeeee
0000000000000000c7c00000000710000000000000000000000000000000000000000000eee888eee777eeee9999eeeeeee0000000ff2eeeeeeeeeeeeeeeeeee
800000000000008007000000000710000000000000000000000000000000000000000000ee888eee799eeeeeeeeeeeeeeee40000ff277eeeeeeeeeeeeeeeeeee
887777777777788007100000000710000000000000000000000000000000000000000000ee8eeeee9999eeeeeeeeeeeeeeee44ffe27657eeeeeeeeeeeeeeeeee
221111111111122007000000000710000000000000000000000000000000000000000000eeeeeeee9999eeeeeeeeeeeeeeeeeeeeee7567eeeeeeeeeeeeeeeeee
200000000000002007000000000820000000000000000000000000000000000000000000eeeeeeee9ee9eeeeeeeeeeeeeeeeeeeeeee77eeeeeeeeeeeeeeeeeee
000000000000000077700000008822000000000000000000000000000000000000000000eeeeeeeeeee9eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
0000000000000000ccc00000000000000000000000000000000000000000000000000000eeeeeeeeee9eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
__sfx__
00010d0e1007009070116600d6500d040090300703005020040200301002010010100101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01020d0e1b660133401966021640146300d620086200662005620046100361003610026101e600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010304356401e6200b6102960000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000180002cb750eb5328a1012e411aa611ae4120e022ae6234e333ce0404b440cb0518b6524b362ab7524b373a300080211807128062360730216416175281072c14628146281462212624126241262613506172
910300000cb510cb410cb310e80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4505102018b6118b5118b4118b3118b2118b2118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b1118b11
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0b00001cc531cc501cc501bc501bc501bc501ac501ac5010c5010c3310c5310c3310c5310c3310c5310c331cc501cc501cc501bc501bc501bc501ac501ac5010d5310d2310d5310d23101230e6150e6150e615
010b000004123000000e6350000004123041230e6350000004123000000e6350000004123041230e6350000004123000000e6350000004123041230e6350000004123041230e6350000004123041230e6351b605
6d0b000010d3310d3310d330fd330fd330fd330ed330ed001dd031dd001dd001dd001dd031dd001dd031dd0017d2317d2317d2316d2316d2316d2315d2315d001cd031cd031cd031cd031cd031cd031cd031cd03
010b000021c5015c0321c5021c5015c0315c0321c4015c0321c5015c0321c5021c5015c0315c0321c4015c031dc501dc031dc531dc431dc331dc331dc331dc331dc531dc031dc531dc431dc331dc331dc331dc33
010b000018c5315c0318c4018c4015c0315c0318c4015c0318c5015c0318c4018c4015c0315c0318c4015c031cc501dc031cc501cc431cc531cc431cc531cc431cc531dc001cc501cc431cc531cc431cc531cc43
010b000024d5015c0324d5324d5015c0315c0324d4315c0324d5315c0324d5324d5015c0315c0324d4315c0321d501dc0321d5321d4321d3321d3321d3321d3321d531dc0321d5321d4321d3321d3321d3321d33
010b000024d5015c0324d5324d5015c0315c0324d4315c0324d5315c0324d5324d5015c0315c0324d4315c032bd501dc032bd532bd432bd332bd3329d4329d4329d401dc0329d5329d4329d3328d3328d3328d33
010b00001dc501dc031dc531dc431dc531dc431dc531dc431fc501dc031fc501fc431fc531fc431fc531fc4321c501dc0321c5021c4321c5321c4321c5321c4321c53000001fc53000001cc530000018c5300000
010b00001dc501dc031dc531dc431dc531dc431dc531dc431fc501dc031fc501fc431fc531fc431fc531fc4321c501dc0321c5021c4321c5321c4321c5321c4321c531dc0321c5021c4321c5321c4321c5321c43
010b00000000000000244402444024440244432344023440244402444024440244402644026440264402644028430284302843028430284322843228432284322645026450244502445024450244502445024453
010b000000000294002945129400294502940029450294001c450294001a4500000018450000001a450000001c45000000000001a4501c4000000018450000001c45000000000001a4501c400000001845000000
010b00001dc501dc031dc531dc431dc531dc431dc531dc431fc501dc031fc501fc431fc531fc431fc531fc431cc501dc031cc501cc431cc531cc431cc531cc431cc531dc031cc501cc431cc531cc431cc531cc43
010b00002145000000214502040021450000002145000000214501800021450204002145018000214500000020450000000000020450000000000020453000002045000000000002045000000000002045000000
490b00001845118451184411844118431184311843118431264512645126441264412643126431264312645128451284512845128451284512845128451284512645126451264512645124451244512445124451
650b00002945129451294412944129431294312943129431284512845128441284412843128431284312845126451264512645126451264512645126451264512645126451264512645124451244512445124451
010b000010173000001017300000000000000000000000000e675000000000000000000000e6750e6550e64510173000001017300000000000000000000000000e675000000000000000000000e6750e6550e645
011100000715507145071550714507155071450715507145071550714507155071450715507145071550714507155071450715507145071550714507155071450715507145071550714507155071450715507145
011100001884018840189401884018840188431894018940188401884018940188401884018843189401894018840188401894018840188401884318940189401884018840189401884018940188401894018943
0911000026560265652456023560235651d5601f5601f5601f5601f5651f5001f5001f5001f500235602456023560235652456026560265652456023560235602356023565235002350023500235001f5601f560
011100001884018840189401884018840188431894018940188401884018940188401884018843189401894018840188401894018840188401884318940189401884018840189401884018840188431894018940
091100002256022565225602256522500225002256022565245612456524560245652450024500245602456523560235651f5621f5621f5621f5651f5001f5001f5001f5001f5001f5001f5001f5001f5001f500
011100000a1550a1450a1550a1450a1550a1450a1550a1450c1550c1450c1550c1450c1550c1450c1550c1450715507145071550714507155071450715507145051550514507155071450a1550a1450715507145
091100000000000000245602456524560245602456524500265602656526560265602656526500265602656524560245601f5601f5601f5601f5601f5651f5001f5001f5001f5001f5001f5001f5001f5001f500
011100000c1550c1450c1550c1450c1550c1450c1550c1450a1550a1450a1550a1450a1550a1450a1550a14507155071450715507145071550714507155071450715507145071550714507155071450715507145
0911000000000000002456024565245602456024565245001d5601d5651f5601f5601f5651f500185601856022560215601f5601f5601f5601f5601f5651f5001f5001f5001f5001f5001f5001f5001f5001f500
051100001f75018750137501f7511f7501f75022752227521b7501a75018750187501875516750187501b7501d7501f7551f7501f7501f7501f755187501b7501675016750167501675016755167001670016700
051100001f75018750137501f7511f7501f75022752227522775026750247502475024755247002275024750227501f7551e7501e7501d7501d7551b7501b7501875016750187501875018750187501875518700
05110000247501f7501875013750247501f7501875013750227501d7501675011750227501d75016750117501f75024750187501b7502775026750247501f7502275024755247522475224752247522475524700
051100002375024750237502475124752247521d7501d7501f7501f7501f7501f7501f7551f7001f7001f7001b7501a7501875016750167501675016750167501675516700167001670016700167001670016700
1111000014b2008b2108b2508b0008b0008b0014b2008b2108b2508b0008b0008b0008b0008b0012b2006b2117b200bb210bb250bb000bb000bb0017b200bb210bb250bb000bb000bb000bb000bb0012b2006b21
01110000188501885018a5018a50189401894018a5018850188501885318a5018a53189401894018a5018a50188501885018a5018a50189401894018a5018850188501885318a5018a53189401894018a5018a53
111100000fb2003b210fb2003b2103b2503b0003b0003b0012b2006b2112b2006b2106b2506b0006b0006b0014b2008b2114b2008b2108b2508b0008b0008b0008b0008b0012b2006b2114b2008b2108b2508b00
01110000188501885018a5018a50189401894018a5018850188501885318a5018a53189401894018a5018a50188501885018a5018a50189401894018a5018850188501885318a501894018a50188501894018940
01110000000000000012155141551415014155121500f1500f1500f1500f1550f1000f1000f1000d1550b1550d1500f1550f1500f1550f1500f1550d150081500815008150081500815508100081000810008100
011100000d1500f1550f1550f1000f1500f1500f15512150121521415014155141501715014150171501315012150121500f1500f155141501215012155171501715217152171551710017100171001710017100
011100000f1500d1500b1500b1550815008150081550615008150081550b1500d1500d1550d1000b1500b15008150081500815208152081550810008100081000810008100081000810008100081000810008100
31110000000000000000000000001b0300f030190301b0300f020190201b0200f010190101b0100f010190101b0101b0151b0001b0001b0001b0001b0001b0001b0001b0001b0001b0001b0001b0001b0001b000
011100000f15012155141501415512150121500f1500d1500d1500d1550d1000b1500d1550b1500d1510b1550d1500f1500d1500d155081500815506150081500815008152081520815508100081000810008100
1111000014b2008b2108b2508b0008b0008b0014b2008b2108b2508b0008b0008b0008b0008b0012b2006b2114b2008b2108b2508b0008b0008b0014b2008b2108b2508b0008b0008b0008b0008b0008b0008b00
01110000188501885018a5018a531894018a50188501885018a5018a5318a53188501894018a501885018850188531885018a5018a531894018a50188501885018a5018a5318a5318850189401894018a5018a53
910f00002d6112f611266112b6112461126611256112a611000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010f0000396103b6113261137611396103b611326113761126611256112a611000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010700001f65300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010700003c63300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010500001f0502b0512b0302b01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
012100002715300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010c00002733000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010c00000c5501855100500105501c55100500135501f550005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
01230000273501b351003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000000000000
01060000186601d1501c1512315100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010600000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000000
__music__
00 4408090a
01 440b090d
00 440c090e
00 440b090d
00 440c090e
00 440f0911
00 44100912
00 440f0911
00 44131409
00 44150b17
02 440c1617
01 40401819
00 401a181b
00 401c1d1b
00 401a181b
00 401c1d19
00 401e1f1b
00 40201f1b
00 401a181b
00 401c1d19
00 40211f1b
00 40221f1b
00 40231f1b
02 40241f19
01 40402526
00 40402526
00 40402726
00 40402728
00 40292526
00 402a2526
00 40292526
00 402b2526
00 402c2726
00 402c2728
00 40292526
00 402a2526
00 40292526
00 412d2526
02 41422e2f
01 41424326
00 41614328
00 41424326
02 4142432f
__label__
llmlmlmlllmlml55mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm5llllllllllllllllllllllllmmmmmmmmmmmmmmmm5555555555555555mmmmmmmmmmmmmmmm55555555
55lllmlllmlm55l5mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm5llllllllllllllllllllllllmmmmmmmmmmmmmm5555555555555555mmmmmmmmmmmmmmmm5555555555
5555llmlll555l55mmmmmmmmmmmmmmmmmmmmmmmmmmm6m655lllllllllllllllllllllllllmmmmmmmmmmm5555555555555555mmmmmmmmmmmmmmmm555555555555
555555ll55l5l5l5mmmmmmmmmmmmmmmmmmmmmmmmmm6m6555lllllllllllllllllllllllllmmmmmmmmm5555555555555555mmmmmmmmmmmmmmmm55555555555555
555555555l5l5l55mmmmmmmmmmmmmmmmmmmmmm5555555555llllllllllllllllllllllllllmmmmmm5555555555555555mmmmmmmmmmmmmmmm5555555555555555
mm55555555l5l5l5mmmmmmmmmmmmmmmmmmmm55m5mm555555llllllllllllllllllllllll6lmmmm5555555555555555mmmmmmmmmmmmmmmm5555555555555555mm
mm55555555555l55mmmmmmmmmmmmmmmmmm555m55mmmm5555lllllllllllllllllllllll6l6mm5555555555555555mmmmmmmmmmmmmmmm5555555555555555mmmm
55m5m555555555l5mmmmmmmmmmmmmmmm55m5m5m5mmmmmm55llllllllllllllllllll6l6l666555555555555555mmmmmmmmmmmmmmmm5555555555555555mmmmmm
5m5m5m5555555555mmmmmmmmmmmmmm555m5m5m55mmmmmmmmlllllllllllllllllll6l6666665555555555555mmmmmmmmmmmmmmmm5555555555555555mmmmmmmm
55m5m5m5555555mmmmmmmmmmmmmm55m555m5m5m5mmmmmmllllllllllllllllll6l6l666666665555555555mmmmmmmmmmmmmmmm5555555555555555mmmmmmmmmm
5m5m5m555m55mmmmmmmmmmmmmm555m555m555m55mmmmlllllllllllllllllll6l6666666666m65555555mmmmmmmmmmmmmmmm5555555555555555mmmmmmmmmmmm
55m5m5m555mmmmmmmmmmmmmm55m5m5m555m5m5m5mmllllllllllllllllll6l6l6666666666m6mmm555mmmmmmmmmmmmmmmm5555555555555555mmmmmmmmmmmmmm
5m5m5m55mmmmmmmmmmmmmmmm5m5m5m555m5m5m55lllllllllllllllllll6l6666666666m6m6mmmmmmmmmmmmmmmmmmmmm5555555555555555mmmmmmmmmmmmmmmm
55m555mmmmmmmmmmmmmmmmmm55m5m5m555m555llllllllllllllllll6l6l6666666666m6mmmmmmmmmmmmmmmmmmmmmm5555555555555555mmmmmmmmmmmmmmmm55
5m55mmmmmmmmmmmmmmmmmmmm5m5l5m555m55llllllllllll5llllll6l6666666666m6m6mmmmmmmmmmmmmmmmmmmmm5555555555555555mmmmmmmmmmmmmmmm5555
55mmmmmmmmmmmmmmmmmmmmmm55m5m5m555llllllllllllll5lll6l6l6666666666m6mmmmmmmmmmmmmmmmmmmmmm5555555555555555mmmmmmmmmmmmmmmm555555
mmmmmmmmmmmmmmmmmmmmmmmm5m5m5m55llllllllllllllll5ll6l6666666666m6m6mmmmmmmmmmmmmmmmmmmmm5555555555555555mmmmmmmmmmmmmmmm55555555
mmmmmmmmmmmmmmmmmmmmmmmm55m555llllllllllllllllll556l6666666666m6mmmmmmmmmmmmmmmmmmmmmmmmmm555555555555mmmmmmmm6666mmmm5555555555
mmmmmmmmmmmmmmmmmmmmmmmm5m55llllllllllllllllllll55666666s66m6m6mmmmmmmmmmmmmmmmmmmmmmmmmm55m55555555mmmmmmmm66mmmm66555555555555
mmmmmmmmmmmmmmmmmmmm5lmm55llllllllllllllllllllll5556666666msmmmmmmmmmmmmmmsmmsmsmmmmmmm55mm55m5555mmmmmmmm66mmmmmmmm665555555555
mmmmmmmmmmmmmmmmmm5l5l5lllllllllllllllllllllllll55566s6m6s6mmmmmmmsmmmmsmmmmsmmmmmmmm55mm55mmmmmmmmmmmmm66mmmmmmmmmmmm6655555555
mmmmmmmmmmmmmmmm5l5l5lllllllllllllllllllllllllmmmm5566msmssmmsmmsmmmsmmmmsmsmsmmmmm55mm55mmmmmmmmmmmmmmm55mmmmmmmmmmmmmm665555mm
mmmmmmmmmmmmmm5l5l5lllllllllllllllllllllllllmmmmmmms5sssssmmmmmmmssmmmsmsmsssmsmm55mm55mmmmmmmmmmmmmmmmm5555mmmmmmmmmmmmmm66mmmm
mmmmmmmmmmmm5l5l5lllllllllllllllllllllllllmmmmmmmmmmmsssssssmmsmssssssmsmsssssm5smm55mmmmmmmmmmmmmmmmmmm555555mmmmmmmmmmmmmm66mm
mmmmmmmmmm5l5l5lllllllllllllllllllllllllmmmmmmmmmsmmsssssssssmmssssssssssssssssmm55mmmmmmmmmmmmmmmmmmmll55555555mmmmmmmmmmmmmm66
mmmmmmmm5l5l5lllllllllllllllllllllllllmmmmmmmmmmmmssssss7sssssssssssssssssss7sms5mmmmmmmmmmmmmmmmmmmllmmmm55555555mmmmmmmmmmmm66
mmmmmm5l5l5lllllllllllllllllllllllllmmmmmmmmmmmmmmmssss7777ssssssssssssssss777smmmmmmmmmmmmmmmmmmmllmmmmmmmm55555555mmmmmmmm6666
mmmm5l5l5lllllllllllllllllllllllllmmmmmmmmmmmmmmmmmmss7777777ssss888888sss777smsmmmmmmmmmmmmmmmmllmmmmmmmmmmmm55555555mmmm666666
mm5l5l5lllllllllllllllllllllllllmmmmmmmmmmmmmmmmmmmsss77777777ssss888888877777smmmmmmmmmmmmmmmllmmmmmmmmmmmmmmmm5555555566666666
5l5l5lllllllllllllllllllllllllmmmmmmmmmmmmmmmmmmmmsssssss7777777sss8777788777smsmmmmmmmmmmmmllmmmmmmmmmmmmmmmmmmmm55555556666666
5l5lllllllllllllllllllllllllmmmmmmmmmmmmmmmmmmmmsmmmsms777777777888777777877mmmmmmmmmmmmmmllmmmmmmmmmmmmmmmmmmmmmmmm555556666666
5lllllllllllllllllllllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmsms7777777778775117778ssmsmmmmmmmmmllmmmmmmmmmmmmmmmmmmmmmmmmmmmm5555666666
llllllllllllllllllllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmsmmsmsss777777777717179ssssmsmmmmmmm5mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm55566666
llllllllllllllllllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsss777777777775117999sssmmmmmmmm555mmmmmmmmmmmmmmmmmmmmmmmmmmmm6665566666
llllllllllllllllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsmsssssss77777777777799999ssssmm6m6555555mmmmmmmmmmmmmmmmmmmmmmmm666666556666
lllllllllllllllll8866mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssss777777777798s999ssss6m6555555555mmmmmmmmmmmmmmmmmmmm66666666656666
lllllllllllllll66888666mmmmmmmmmmmmmmmmmmmmmmmmmmsmssssssssss7777777777s988ss9sssss5555555555555mmmmmmmmmmmmmmmm6666666666665666
lllllllllllll66666686s666mmmmmmmmmmmmmmmmmmmmmmmmms5sssssss8877777777ssss999sss111ss5566mm55555555mmmmmmmmmmmm666666666666666566
llllllllllllm66666666sss666mmmmmmmmmmmmmmmmmmmmmm55sms8888888777777777ssssssss11111s66mmmmmm55555555mmmmmmmm66666666666666666666
llllllllllmm6555666666ss6566lmmmmmmmmmmmmmmmmmm55mm5sss8888877777777777s999s1111111smmmmmmmmmm55555555mmmm6666666666666666666666
llllllllmmm655555566666555566ll6mmmmmmmmmmmmm55mm55smsss88887777777777799s191111112smmmmmmmmmmmm55555555666666666666666666666666
llllllmmmmm6555555556555555666666mmmmmmmmmm55mm55smmsss888888s77777ss7791111111111fmmmmmmmmmmmmmmm5555555666666666666666666666mm
llllmmmmmm6555555555655555566ll66mmmmmmmm55mm55mmmmmmssss888sss777ssss99991111111fmmmmmmmmmmmmmmmmmm555555666666666666666666mmmm
llmmmmmmm66665555556l5555666l6ll5mmmmmm55mm55mmmmmmmsmss888sss799sss11111111111ffmmmmmmmmmmmmmmmmmmmmm55555666666666666666mmmmmm
mmmmmmmmm22666655556ll566666ll65mmmmm55mm55mmmmmmmmsmsss8mmsss999911111111111ff2smmmmmmmmmmmmmmmmmmmmmmm5555666666666666mmmmmmmm
mmmmmmmmm2225666656l66666665ll5mmmm55mm55mmmmmmmmmmmmmsmssssss9999111111111ff277ssmmmmmmmmmmmmmmmmmmmmmmmm555666666666mmmmmmmmmm
mmmmmmmmm552552666666ll6655mmmmmm55mm55mmmmmmmmmmmmmmmmsssssss91191111111ffs27657smmmmmmmmmmmmmmmmmmmmmmmmmm55666666mmmmmmmmmmmm
mmmmmmmmmmm555222666l6ll5mmmmmm55mm55mmmmmmmmmmmmmmmsmssssss11111911111ffssss7567mmmmmmmmmmmmmmmmmmmmmmmmmmmmm5666mmmmmmmmmmmmmm
mmmmmmmmmmmmm5522666ll65mmmmm55mm55mmmmmmmmmmmmmmmsmmssss111111191111ffs55s5ss77mmmmmmmmmmmmmm66666666666666666666mmmmmmmmmmmmmm
mmmmmmmmmmmmmmm55665ll5mmmm55mm55mmmmmmmmmmmmmmmmmmsmsss11111111111ffsmmms5s5ss555mmmmmmmmmm666666666666666666666666mmmmmmmmmmmm
mmmmmmmmmmmmmmmmmm5mmmmmm55mm55mmmmmmmmmmmmmmmmmmmsmssss111111111ffsmmmmmmmm55555555mmmmmmmm66m5lmmmmmmmmmmmmmm5lm6666mmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmm55mm55mmmmmmmmmmmmmmmmmmmmm6s6sss1111111ff2sddddddddddd55555555mmmmmmmmm5lmmmmmmmmmmmmmm5lmmm6666mmmmmmmm
mmmmmmmmmmmmmmmmmmmmm55mm55mmmmmmmmmmmmm666666666666s6ss21111ff277ssddddddddddddddddddddmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm6666mmmmmm
mmmmmmmmmmmmmmmmmmm55mm55mmmmmmmmm666666666666666666sssss22ffs27657sssssssssdddddddddddd55mmmmmmmmmmmmmmmmmmmmmmmmmmmmm56666mmmm
mmmmmmmmmmmmmmmmm55mm55mmmmm666666666666666ssssssssssssssssssss7567ssssssssssssssssssddssss5mmmmmdddmmmmmmmmmmmmmmmmmmm5lm6666mm
mmmmmmmmmmmmmmm55mm55mmm6666666666666sssssssssssssssssssssssssss77ssssssssssssssssssssssssssssssddddddddmmmmmmmmmmmmmmm5lmmm6666
mmmmmmmmmmmmm55mm55m666666666666ssssssssssssssssssssjjjjjjjjjjjssjjjjjjjjjjjssssssssssssssssssss666dddddddddmmmmmmmmmmmmmmmmmm66
mmmmmmmmmmm55mm56666666666666ssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjssssssssssssss666ddddddddddmmmmmmmmmmmmmmm5
mmmmmmmmm55mm666666666666ssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjssssssssssss666dddddddddmmmmmmmmmmmm5
mmmmmmm55mm66666666666sssssssssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjsssssssssss66666666dddmmmmmmmmmm5
mmmmm55m666666666666sssssssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjsssssssss66666666666dmmmmmmmm
mmm55m666666666677777777ss77777777jj77j7777jjjj77jjjjjj77jjjjjjj77jjjjj77jjjj77777jjj77jjjjjjjjjjj77jj77sssss7766666666666mmmmmm
m55m66666666666s77777777jj77777777jj77777777jjj777jjjj777jjjjjjj77jjjjj77jjj7777777jj77jjjjjjjjjjj77jj77jsss777ss66666666666mmmm
5m66666666666ssss11771111jj11771111j777j11777jjj777jj77711jjjjjj771jjjj771jj7711177jjj77jjjjjjjjj7711j771jj77711sss66666666666mm
66666666666ssssss11771111jj11771111j771111177jjj1777777111jjjjjj771jjjj771jj77111771jj77jjjjjjjjj7711j771j777111sssss66666666666
6666666666ssssssjjj771jjjjjjj771jjjj7711jjj771jjj17777111jjjjjjj771jjjj771jjj11jj771jj771jjj7jjjj771jj771777111jssssss6666666666
66666666ssssssjjjjj771jjjjjjj771jjjj771jjjj771jjjj177111jjjjjjjj7777777771jjj7777771jj771jj777jjj771jj77777111jjjjssssss66666666
6666666ssssssjjjjjj771jjjjjjj771jjjj771jjjj771jjjjj7711jjjjjjjjj7777777771jj77777771jjj77jj777jj7711jj7777771jjjjjjssssss6666666
666666sssssjjjjjjjj771jjjjjjj771jjjj771jjjj771jjjjj771jjjjjjjjjj7711111771jj77111771jjj77j77177j7711jj7771177jjjjjjjjsssss666666
66666sssssjjjjjjjjj771jjjjjjj771jjjj771jjjj771jjjjj771jjjjjjjjjj7711111771jj77111771jjj77177177j771jjj77111177jjjjjjjjsssss66666
6666sssssjjjjjjjjjj771jjjjjjj771jjjj771jjjj771jjjjj771jjjjjjjjjj771jjjj771jj771jj771jjj771771771771jjj7711jj177jjjjjjjjsssss6667
666sssssjjjjjjjjjjj771jjjj77777777jj771jjjj771jjjjj771jjjjjjjjjj771jjjj771jj77777777jjjj77711j77711jjj771jjjj77jjjjjjjjjsssss777
66sssssjjjjjjjjjjjj771jjjj77777777jj771jjjj771jjjjj771jjjjjjjjjj771jjjj771jjj77777177jjj77j11j17711jjj771jjjj771jjjjjjjjjsssss77
66ssssjjjjjjjjjjjjjj11jjjjj11111111jj11jjjjj11jjjjjj11jjjjjjjjjjj11jjjjj11jjj11111111jjjj111jjj111jjjjj11jjjjj11jjjjjjjjjjssss77
6ssssjjjjjjjjjjjjjjj11jjjjj11111111jj11jjjjj11jjjjjj11jjjjjjjjjjj11jjjjj11jjjj11111j11jjj11jjjjj11jjjjj11jjjjj11jjjjjjjjjjjssss7
6ssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjssss7
sssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjsssss
ssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjssss
ssssjjjjjjjjjjj777777jjjj7777777jjjjj777777jjjj7777777jjjjjjjjjjjjjjj777777jjjjj777jj777jjjjj7777777jjjjj777777jjjjjjjjjjjjjssss
ssssjjjjjjjjjjj777j777jjjjj777jjjjjj777jjj7jjj777jjj777jjjjjjjjjjjjj777jj777jjjj777jj777jjjj777jjj777jjjj777j777jjjjjjjjjjjjssss
ssssjjjjjjjjjjjaaa11aaajjj1aaa111jjaaa111111jaaa11111aaajjjjjjjjjjjaaa1111aaajjjaaa1jaaa1jjaaa11111aaajjjaaa11aaajjjjjjjjjjjssss
ssssjjjjjjjjjjjaaa1jaaajjjjaaa1jjjjaaa11jjj1jaaa11jjjaaajjjjjjjjjjjaaa11jjaaajjjaaa1jaaa1jjaaa11jjjaaajjjaaa1jaaajjjjjjjjjjjssss
sssssjjjjjjjjjjaaa1jaaa1jjjaaa1jjjjaaa1jjjjjjaaa1jjjjaaa1jjjjjjjjjjaaa1jjjj111jjaaa1jaaa1jjaaa1jjjjaaa1jjaaa1jaaa1jjjjjjjjjsssss
dssssjjjjjjjjjjaaa1jaaa1jjjaaa1jjjjaaa1jjjjjjaaa1jjjjaaa1jjjjjjjjjjaaa1jjjj111jjaaa1jaaa1jjaaa1jjjjaaa1jjaaa1jaaa1jjjjjjjjjssss7
dssssjjjjjjjjjjaaa1jaaa1jjjaaa1jjjjaaa1jjjjjjaaa1jjjjaaa1jjjjjjjjjjaaa1jjjjjjjjjaaa1jaaa1jjaaa1jjjjaaa1jjaaa1jaaa1jjjjjjjjjssss7
ddssssjjjjjjjjjaaa1jaaa1jjjaaa1jjjjaaa1jjjjjjaaa1jjjjaaa1jjjjjjjjjjaaa1jjjjjjjjjaaa1jaaa1jjaaa1jjjjaaa1jjaaa1jaaa1jjjjjjjjssss77
ddsssssjjjjjjjjaaa1jaaa1jjjaaa1jjjjaaa1jjjjjjaaa1jjjjaaa1jjjjjjjjjjjaaajjjjjjjjjaaa1aaa11jjjaaajjjaaa11jjaaa1aaa11jjjjjjjsssss77
dddsssssjjjjjjj9a91ja9a1jjja9a1jjjja9a1jjjjjja9a1jjjja9a1jjjjjjjjjjj1a9a9a9jjjjj9a9a9a111jjj1a9a9a9a111jj9a9a9a111jjjjjjsssss777
ddddsssssjjjjjja9a1a9a11jjj9a91jjjj9a91jjjjjj9a91jjjj9a91jjjjjjjjjjjj111j9a9jjjja9a1a9a1jjjja9a1jja9a1jjja9a1a9a1jjjjjjsssss7777
dddddsssssjjjjj999999111jjj9991jjjj9991jjjjjj9991jjjj9991jjjjjjjjjjjjj1111999jjj99911999jjj99911111999jjj99911999jjjjjsssss77777
ddddddsssssjjjj9991j111jjjj9991jjjj9991jjjjjj9991jjjj9991jjjjjjjjjjjjjjjjj999jjj9991j999jjj99911jjj999jjj9991j999jjjjsssss777777
dddddddssssssjj9991111jjjjj9991jjjj9991jjjjjj9991jjjj9991jjjjjjjjjj999jjjj9991jj9991j9991jj9991jjjj9991jj9991j9991jssssss7777777
ddddddddssssssj9991jjjjjjjj9991jjjj9991jjjjjj9991jjjj9991jjjjjjjjjj999jjjj9991jj9991j9991jj9991jjjj9991jj9991j9991ssssss77777777
ddddddddddsssss9991jjjjjjjj9991jjjjj999jjj9jjj999jjj99911jjjjjjjjjjj999jj99911jj9991j9991jjj999jjj99911jj9991j9991ssss7777777777
dddddddddddssss9991jjjjjj9999999jjjj1999999jjj19999999111jjjjjjjjjjj1999999111jj9991j9991jjj19999999111jj9991j9991sss77777777777
mmdddddddddddsss111sjjjjjjjj111jjjjjj111jjj1jjj111jjj111jjjjjjjjjjjjj111jj111jjjj111jj111jjjj111jjj111jjjj111ss111s77777777777m5
mmmmddddddddddds111ssssjjj1111111jjjjj111111jjjj1111111jjjjjjjjjjjjjjj111111jjjjj111jj111jjjjj1111111jjjjs111ss1117777777777mmmm
mmmmmmdddddddddddsssssssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjsssssssss77777777777mmmmmm
mmmmllllddddddddddddsssssssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjsssssssss777777777777mmmmmmmm
mmllllllmmmdddddddddddsssssssssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjsssssssssss66777777777mm55mmmmmmm
llllllllmmmmmddddddddddddssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjssssssssssss666667777777mm55mm55mmmmm
llllllllmmmmmmmmdddddddddddddssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjssssssssssssss6666666667777mmmmmmm55mm55mmm
llllllllmmmmmmmmmmmmddddddddddddssssssssssssssssssssjjjjjjjjjjjjjjjjjjjjjjjjssssssssssssssssssss666666666666mmmmmmmmmmmmm55mm55m
llllllllmmmmmmmmmm666666dddddddddddddssssssssssssssssssssssssssssssssssssssssssssssssssssssdddd666666666mmmmmmmmmmmmmmmmmmm55mm5
llllllllmmmmmmmm666666666666dddddddddddddddssssssssssssssssssssssssssssssssssssssssssdddddddddddd666mmmmmmmmmmmmmmmmmmmmmmmmm55m
llllllllmmmmmmll566666666666655555ddddddddddddddddddssssssssssssssssssssssssddddddddddddddddddmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm5
llllllllmmmmllll55666666666666555555mmmmddddddddddddddddddddddddddddddddddddddddddddddddlm6666mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
llllllllmmllllll5556666666666665555555mmmmmmmmmmmmddddddddddddddddddddddddddddmmmmmmmmm5lmmm6666mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
llllllllllllllll555566666666666655555555mmmmmmmmmmmmmmmmmmmmmmmm666666666666mmmmmmmmmmmmmmmmmm6666mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
llllllllllllllmmmm555666666666mmmm55555555mmmmmmmmmmmmmmmmmmmmmm5666666666666mmmmmmmmmmmmmmmmmm56666mmmmmmmmmmmmmmmmmmmmmmmmmmmm
llllllllllllmmmmmmmm55666666mmmmmmmm55555555mmmmmmmmmmmmmmmmmmmm55666666666666mmmmmmmmmmmmmmmmm5lm6666mmmmmmmmmmmmmmmmmmmmmmmmmm
llllllllllmmmmmmmmmmmm5666mmmmmmmmmmmm55555555mmmmmmmmmmmmmmmmmm555666666666666mmmmmmmmmmmmmmmm5lmmm6666mmmmmm66mmmmmmmmmmmmmmmm
llllllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm55555555mmmmmmmmmmmmmmmm5555666666666666mmmmmmmmmmmmmmmmmmmmmm6666mmmmmm66mmmmmmmmmmmmmm
lllllllllmllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm55555555mmmmmmmmmmmmmmmm555666666666mm66mmmmmmmmmmmmmmmmmmmmm56666mmmmmmmmmmmmmmmmmmmm
llllmlmlllmlllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm55555555mmmmmmmmmmmmmmmm55666666mmmmmm66mmmmmmmmmmmmmmmmmmm5lm66mmmmmmmmmmmmmmmmmmmm
lllmlmlllmlmlmllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm55555555mmmmmmmmmmmmmmmm5666mmmmmmmmmm66mmmmmmmmmmmmmmmmm5lmmmmmmmmmmmmmmmmmmmmmmm
llmlmlmlllmlmlmlllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm66666666mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm66mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmlllmlllmlmlmlllmllmmmmmmmmmmmmmmmmmmmmmmmmmm66666666mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmllmlllmlmlmlllmlllmmmmmmmmmmmmmmmmmmmmmm66mmmm66mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmllllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmlllmlmlmlllmlmlmllmmmmmmmmmmmmmmmmmm66mmmmmmmm66mmmmmmmmmmmmmmmmmmmmmmmmmmmmllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmllmlmlmlllmlmlmlllmmmmmmmmmmmmmm66mmmmmmmmmmmm66mmmmmmmmmmmmmmmmmmmmmmmmllllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmml
mmmmmm5555lllmlllmlmlmlllmllmmmmmmmmmmmm55mmmmmmmmmmmmllmmmmmmmmmmmmmmmmmmmmmmllllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmlll
mmmm55555555llmlllmlmlmlllmlllmmmmmmmmmm5555mmmmmmmmllllmmmmmmmmmmmmmmmmmmmmllllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmlllll
mm555555555555lllmlmlmlllmlmlmllmmmmmmmm555555mmmmllllllmmmmmmmmmmmmmmmmmmllllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmlllllll
5555555555555555llmlmlmlllmlmlmlllmmmmmm55555555llllllllmmmmmmmmmmmmmmmmllllllllmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm65llllll
55555555555555mmmmlllmlllmlmlmlllmllmmmm55555555llllllllmmmmmmmmmmmmmmllllllllmmmmmmmmmmmmmmmmmmmmmmmm6666mmmmmmmmmmmmm655llllll
555555555555mmmmmmmmllmlllmlmlmlllmlllmm55555555llllllllmmmmmmmmmmmmllllllllmmmmmmmmmmmmmmmmmmmmmmmm66mmmm66mmmmmmmmmm5555lll6l6
5555555555mmmmmmmmmmmmlllmlmlmlllmlmlmll55555555llllllllmmmmmmmmmmllllllllmmmmmmmmmmmmmmmmmmmmmmmm66mmmmmmmm66mmmmmmmmmm55ll6l66
__meta:title__
tinyhawk
by morganquirk
