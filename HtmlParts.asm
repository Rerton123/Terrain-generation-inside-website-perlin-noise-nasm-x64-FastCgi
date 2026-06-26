h1 db 10,10,"<img src='/img/0.bmp'style='width:100%;height:100%;display:block;position:absolute;top:0%;left:0%;z-index:-1'>",10,\
"<form method='POST' style='position:absolute; top:100px; left:0px; display:flex; gap:10px; max-width:400px; margin:20px'>",10,\
"<input type='text' name='1' pattern='[A-Za-z0-9]+' maxlength='16' placeholder='Username' style='flex:1;padding:8px;font-size:16px'>",10,\
"<input type='text' name='2' pattern='[A-Za-z0-9]+' maxlength='16' placeholder='Password' style='flex:1;padding:8px;font-size:16px'>",10,\
"<button type='submit' style='padding:8px 16px; font-size:16px; cursor:pointer'>Login</button>",10,\
"</form>",10,\
"<form method='POST' style='position:absolute; top:150px; left:0px; display:flex;gap:10px;max-width:400px;margin:20px'>",10,\
"<input type='text' name='3' pattern='[A-Za-z0-9]+' maxlength='16' placeholder='Username' style='flex:1;padding:8px;font-size:16px'>",10,\
"<input type='text' name='4' pattern='[A-Za-z0-9]+' maxlength='16' placeholder='Password' style='flex:1;padding:8px;font-size:16px'>",10,\
"<button type='submit' style='padding:8px 16px;font-size:16px;cursor:pointer'>Register</button>",10,\
"</form>",10,\
0
h1l equ $ - h1

h2 db 10,"<img src='/img/1.bmp'style='width:100%;height:100%;display:block;position:absolute;top:0%;left:0%;z-index:-1'>",\
"<form method='POST'>",\
"<button id='img2' name='6' value='1' style='background:url(/img/2.bmp);background-size: cover;width:200px;height:100px;display:block;position:absolute;top:-20%;left:calc(50% - 100px);z-index:1'></button>",\
"</form>",\
"<form method='POST'>",\
"<button id='img3' name='5' value='2' style='background:url(/img/3.bmp);background-size: cover;width:300px;height:150px;display:block;position:absolute;top:calc(-20% - 160px);left:calc(50% - 150px);z-index:2'></button>",\
"</form>",\
"<form method='POST'>",\
"<button id='img4' name='0' value='1' style='background:url(/img/4.bmp);width:100px;height:50px;display:block;position:absolute;top:calc(-20% + 110px);left:calc(50% - 50px);z-index:3'></button>",\
"</form>",\
"<img id='img5' src='/img/5.bmp'style='width:440px;height:540px;display:block;position:absolute;top:calc(-20% - 270px);left:calc(50% - 220px);image-rendering: pixelated;z-index:0'>"
h2l equ $ - h2

h3 db 10,"<img src='/img/10.bmp'style='width:100%;height:100%;display:block;position:absolute;top:0%;left:0%;z-index:-1;image-rendering: pixelated;'>",\
"<form method='POST'>",\
"<button id='img4' name='5' value='0' style='background:url(/img/4.bmp);width:100px;height:50px;display:block;position:absolute;top:5%;left:5%;z-index:3'></button>",\
"</form>",\
"<form method='POST'>",\
"<button id='img17' name='5' value='3' style='background:url(/img/17.bmp);width:32px;height:32px;display:block;position:absolute;bottom:5%;right:5%;z-index:3'></button>",\
"</form>"
h3l equ $ - h3



h4 db 10,"<img src='/img/9.bmp'style='width:100%;height:100%;display:block;position:absolute;top:0%;left:0%;z-index:-1'>",\
"<form method='POST'>",\
"<button id='img4' name='5' value='0' style='background:url(/img/4.bmp);width:100px;height:50px;display:block;position:absolute;top:5%;left:5%;z-index:3'></button>",\
"</form>",\
"<form method='POST'>",\
"<button id='img11' name='5' value='0' style='background:url(/img/11.bmp);width:50px;height:50px;display:block;position:absolute;top:5%;left:calc(50% + 51px);z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"</form>",\
"<form method='POST'>",\
"<button id='img12' name='5' value='0' style='background:url(/img/12.bmp);width:50px;height:50px;display:block;position:absolute;top:5%;left:calc(50% + 102px);z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"</form>",\
"<form method='POST'>",\
"<button id='img13' name='5' value='0' style='background:url(/img/13.bmp);width:50px;height:50px;display:block;position:absolute;top:5%;left:calc(50% + 153px);z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"</form>",\
"<form method='POST'>",\
"<button id='img14' name='5' value='0' style='background:url(/img/14.bmp);width:50px;height:50px;display:block;position:absolute;top:5%;left:calc(50% + 204px);z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;></button>",\
"</form>",\
"<form method='POST'>",\
"<button id='img15' name='5' value='0' style='background:url(/img/15.bmp);width:50px;height:50px;display:block;position:absolute;top:5%;left:calc(50% + 255px);z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"</form>",\
"<form method='POST'>",\
"<button id='img16' name='5' value='0' style='background:url(/img/16.bmp);width:50px;height:50px;display:block;position:absolute;top:5%;left:calc(50% + 306px);z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"</form>"
h4l equ $ - h4
; 0-exit; 1-loginUser; 2-loginPass; 3-RegUser;4-RegPass;5-Online;6-Singleplayer




ReturnB1 db "<form method='POST'>",\
"<button name='5' value='2' style='background:url(/img/16.bmp);width:50px;height:50px;display:block;position:absolute;top:5%;left:50%;z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"</form>"
ReturnB1L equ $ - ReturnB1
ResetB1 db "<form method='POST'>",\
"<button name='6' value='1' style='background:url(/img/18.bmp);width:50px;height:50px;display:block;position:absolute;top:5%;left:55%;z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"</form>"
ResetB1L equ $ - ResetB1
BuildB1 db "<form method='POST'>",\
"<button name='7' value='b100' style='background:url(/img/19.bmp);width:50px;height:50px;display:block;position:absolute;top:5%;left:60%;z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"</form>"
BuildB1L equ $ - BuildB1

BuildMenu db "<form method='POST'>",\
"<button name='7' value='00' style='background:url(/img/a00.bmp);width:32px;height:32px;display:block;position:absolute;top:1%;left:2%;z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"<button name='7' value='02' style='background:url(/img/a02.bmp);width:32px;height:32px;display:block;position:absolute;top:1%;left:4%;z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"<button name='7' value='04' style='background:url(/img/a04.bmp);width:32px;height:32px;display:block;position:absolute;top:1%;left:6%;z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"<button name='7' value='06' style='background:url(/img/a06.bmp);width:32px;height:32px;display:block;position:absolute;top:1%;left:8%;z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"<button name='7' value='08' style='background:url(/img/a08.bmp);width:32px;height:32px;display:block;position:absolute;top:1%;left:10%;z-index:3;background-repeat: no-repeat;background-size: contain;image-rendering: pixelated;'></button>",\
"</form>"
BuildMenuL equ $ - BuildMenu
Style db "<style>",13,10,\
    "t{",\
    "width:2%;",\
    "height:4%;",\
    "display:block;",\
    "position:absolute;",\
    "background-repeat:no-repeat;",\
    "background-size: 100% 100%;",\
    "image-rendering:pixelated;",\
    "border:none;",\
    "cursor:pointer;",\
    "z-index:0",\
"}",13,10,\
"</style>"
StyleL equ $ - Style