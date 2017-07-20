
function pair_no  = user_selection(ListPair,Line_new,ListPoint_new, Ic,P)


if P.pair_sel
    
    im1 = zeros(size(Ic,1),size(Ic,2)) ;
    
    for cnt=1:size(ListPair,1)
        n1 = ListPair(cnt,1) ;
        n2 = ListPair(cnt,2) ;
        pts1 = ListPoint_new{n1} ;
        pts2 = ListPoint_new{n2} ;
        im1([pts1;pts2]) = cnt ;
    end
    
    
    display('Select an area please!')
    pause(0.5)
    figure(41), imshow(Ic);
    h = imfreehand;
    position = wait(h);
    
    BW = createMask(h) ;
    
    im2 = BW.*im1 ;
    InlierPair = unique(im2) ;
    InlierPair(InlierPair==0) =[];
    
    draw_Spairs(ListPair,InlierPair,Line_new,Ic,42)
end

prompt2 = 'Which pair do you select?';
pair_no = input(prompt2) ;

end


