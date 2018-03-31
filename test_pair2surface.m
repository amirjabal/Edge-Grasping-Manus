% 
% 
% q10 = 16;
% 
% lineI = Line_new(ListPair(q10,1),:) ;
% lineJ = Line_new(ListPair(q10,2),:) ;
% 
% ptd1 = [lineI(1) ; lineI(2)] ;
% ptd2 = [lineI(3) ; lineI(4)] ;
% ptd3 = [lineJ(1) ; lineJ(2)] ;
% ptd4 = [lineJ(3) ; lineJ(4)] ;
% if (norm(((ptd1+ptd3)/2)-((ptd2+ptd4)/2)) > norm(((ptd1+ptd4)/2)-((ptd2+ptd3)/2)))
%     wint = [ptd1 ptd3 ptd4 ptd2] ;
% else
%     wint = [ptd1 ptd4 ptd3 ptd2] ;
% end
% 
% maskTot = roipoly(Id, wint(2,:), wint(1,:)) ;
% maskTot = double(maskTot) ;
% pixelIndexList = label2idx(maskTot);
% data1 = SL(pixelIndexList{1,1}) ;
% targetLabel = median(data1) ;
% indLabel = find(SL==targetLabel ) ;
% 
% 
% ihh = false(size(Id)) ;
% ihh(indLabel) = true ;
% figure; imshow(ihh)
% 
% % BI = imoverlay(Ic,maskTot,'red');
% % figure;imshow(BI)
% % figure;imshow(maskRegion)
% 
% P.Cons_Cam = 535;     % PRIME SENSE FOCAL LENGTH
% P.center = [ 317.8042  239.2228];
% [pcloud, ~] = depthToCloud_v2(Id_o,P.Cons_Cam , [1 1], P.center) ;
% %figure; plot3(pcloud(:,:,1),pcloud(:,:,2),pcloud(:,:,3),'.k') ;
% pcloudL1 = pcloud(:,:,1) ; pcloudL2 = pcloud(:,:,2) ; pcloudL3 = pcloud(:,:,3) ;
% intestRegion3D(:) = pcloudL1(indLabel) ; intestRegion3D(2,:) = pcloudL2(indLabel) ; intestRegion3D(3,:) = pcloudL3(indLabel) ;
% [coeff,score,latent] = pca(intestRegion3D') ;



for cnt1=1:size(ListPair,1)
    lineI = Line_new(ListPair(cnt1,1),:) ;
    lineJ = Line_new(ListPair(cnt1,2),:) ;
    
    ptd1 = [lineI(1) ; lineI(2)] ;
    ptd2 = [lineI(3) ; lineI(4)] ;
    ptd3 = [lineJ(1) ; lineJ(2)] ;
    ptd4 = [lineJ(3) ; lineJ(4)] ;
    if (norm(((ptd1+ptd3)/2)-((ptd2+ptd4)/2)) > norm(((ptd1+ptd4)/2)-((ptd2+ptd3)/2)))
        wint = [ptd1 ptd3 ptd4 ptd2] ;
    else
        wint = [ptd1 ptd4 ptd3 ptd2] ;
    end
    
    maskTot = roipoly(Id, wint(2,:), wint(1,:)) ;
    maskTot = double(maskTot) ;
    pixelIndexList = label2idx(maskTot);
    data1 = SL(pixelIndexList{1,1}) ;
    targetLabel = median(data1) ;
    indLabel = find(SL==targetLabel) ;
    pair2SurfMat(cnt1,1) =  targetLabel ;

%     ihh = false(size(Id)) ;
%     ihh(indLabel) = true ;
%     figure; imshow(ihh)
    
    
    
end
