

in1 = DE_o ; 

DE_c  = bwmorph(in1,'close')   ;
DE_sk = bwmorph(DE_c,'skel',100);

%DE_sh = bwmorph(DE_sk,'shrink') ;
DE_sh = DE_sk ; 


DE_cl = bwmorph(DE_sh,'clean')  ;
DE_hb = bwmorph(DE_cl,'hbreak',5000) ;



%DE_sp = bwmorph(DE_hb,'spur',2) ;
DE_sp =DE_hb ; 

DE_cl2 = bwmorph(DE_sp,'clean') ;


% added on july 12 2016
se = strel('disk',2);
closeBW = imclose(DE_cl2,se) ;
DE11 =  bwmorph(closeBW,'thin',10);


out1 = DE11 ;


draw_2LogicalOnImage(in1,out1,Ic,'red:in   blue:out',13)
