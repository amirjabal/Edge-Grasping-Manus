
%ListPair % pair of 8th elements
%Line_new % element 8 is the counter of the lines
%ListPoint_new %


% distance 3d

%make point cloud from the original depth
%[pcloud1,~] = depthToCloud_v2(Id,P.Cons_Cam, [1 1],P.center) ; %center = [imw/2 imh/2]
%Z1 = pcloud1(:,:,3) ; X1 = pcloud1(:,:,1) ; Y1 = pcloud1(:,:,2) ;

[mx,~] = size(ListPair) ;

for n=1:mx
    i = ListPair(mx,1) ;
    j = ListPair(mx,2) ;
    Linei = Line_new(i,:) ;
    Linej = Line_new(j,:) ;
    Pi = ListPoint_new{i} ;
    Pj = ListPoint_new{j} ;
    
    %% length of lines in 3d
    Line1_3dLength
    Line1_nPixel
    Line2_3dLength
    Line2_nPixel
    Line1_density = Line1_nPixel/Line1_3dLength ;
    Line2_density = Line2_nPixel/Line2_3dLength ;
    
    %% angle between two line in 3d
    ang_3d = acosd(dot(Dir_XXP1,Dir_XXP2)/(norm(Dir_XXP1)*norm(Dir_XXP1))) ;
    
    %% 3d distance of point from line: distance of the mean point on the
    disL1L2_2d
    dis_L1L2_3d
    
    %% ratio of overlap ??
    
    
    %% pair label ??
    
    %% average depth of lines
    point_m1 = mean(LL1,2) ;
    point_m2 = mean(LL2,2) ;
    point_ave = 0.5*(point_m1 + point_m2) ;
    point_ave
    
    %% distance from the center of clutter
    
    
    %% feature vector elements
    
end


%%
% compare the statistics extracted from
% the masks on 2 sides of an edge
[GxRaw, GyRaw] = imgradientxy(Id);
[GmagRaw, GdirRaw] = imgradient(GxRaw, GyRaw);

close all
% question: how to handle shadows?
n = 16
[wint, winp, winn] = make_RecMask(LineInteresting(n,:),15) ;
maskTot = roipoly(Id, wint(2,:), wint(1,:)) ;
maskpos= roipoly(Id, winp(2,:), winp(1,:)) ;
maskneg= roipoly(Id, winn(2,:), winn(1,:)) ;

dVal_Pos = Id.*maskpos ;
dVal_Pos = dVal_Pos(:) ;
dVal_Pos(dVal_Pos==0)=[];

dVal_Neg = Id.*maskneg ;
dVal_Neg = dVal_Neg(:) ;
dVal_Neg(dVal_Neg==0)=[];

gVal_Pos = Gdir.*maskpos ;
gVal_Pos = gVal_Pos(:) ;
gVal_Pos(gVal_Pos==0)=[];

gVal_Neg = Gdir.*maskneg ;
gVal_Neg = gVal_Neg(:) ;
gVal_Neg(gVal_Neg==0)=[];

gRVal_Pos = GdirRaw.*maskpos ;
gRVal_Pos = gRVal_Pos(:) ;
gRVal_Pos(gRVal_Pos==0)=[];

gRVal_Neg = GdirRaw.*maskneg ;
gRVal_Neg = gRVal_Neg(:) ;
gRVal_Neg(gRVal_Neg==0)=[];

edges = [-180:10:180];

figure; hold on ;
subplot(1,2,1);histogram(dVal_Neg);
subplot(1,2,2);histogram(dVal_Pos); hold off

figure; hold on ;
subplot(2,2,1) ; histogram(gRVal_Neg,edges);
subplot(2,2,2) ; histogram(gRVal_Pos,edges);
subplot(2,2,3) ; histogram(gVal_Neg,edges);
subplot(2,2,4) ; histogram(gVal_Pos,edges); hold off



DrawLineFeature(LineInteresting(n,:),Ic,'Target Line',21)
draw_2LogicalOnImage(maskpos,maskneg,Ic,'masks',22)

h2_neg = histogram(gRVal_Neg,edges);
temp1 = h2_neg.Values ;
h2_pos =  histogram(gRVal_Pos,edges);
temp2 = h2_pos.Values ;
figure;plot(temp1);hold on ; plot(temp2) ; hold off