
%ListPair % pair of 8th elements
%Line_new % element 8 is the counter of the lines
%ListPoint_new % 


% distance 3d

%make point cloud from the original depth
[pcloud1,~] = depthToCloud_v2(Id,P.Cons_Cam, [1 1],P.center) ; %center = [imw/2 imh/2]
Z1 = pcloud1(:,:,3) ; X1 = pcloud1(:,:,1) ; Y1 = pcloud1(:,:,2) ;

[mx,~] = size(ListPair) ;

for n=1:mx
    i = ListPair(mx,1) ;
    j = ListPair(mx,2) ;
    Linei = Line_new(i,:) ;
    Linej = Line_new(j,:) ;
    Pi = ListPoint_new{i} ;
    Pj = ListPoint_new{j} ;
    
    %% length of lines in 3d
    Li = norm([X1(Pi(1))-X1(Pi(end)) ; Y1(Pi(1))-Y1(Pi(end)) ; Z1(Pi(1))-Z1(Pi(end)) ]) ;
    Lj = norm([X1(Pj(1))-X1(Pj(end)) ; Y1(Pj(1))-Y1(Pj(end)) ; Z1(Pj(1))-Z1(Pj(end)) ]) ;
    
    %% angle between two line in 3d
    ang = acosd (dot ( [X1(Pi(1))-X1(Pi(end)) ; Y1(Pi(1))-Y1(Pi(end)) ; Z1(Pi(1))-Z1(Pi(end)) ] ,...
                 [ X1(Pj(1))-X1(Pj(end)) ; Y1(Pj(1))-Y1(Pj(end)) ; Z1(Pj(1))-Z1(Pj(end)) ]  )  / (Li*Lj));
    
    
    %% 3d distance of point from line: distance of the mean point on the
    % shorter line from the longer line ( d = |AxB| / |B| )
    if length(Pi)>length(Pj)
       p_m = [ mean(X1(pj(:))); mean(Y1(pj(:))); mean(Z1(pj(:))) ] ;
       d   = norm (cross( (p_m - [X1(Pi(1)) ; Y1(Pi(1)) ; Z1(Pi(1)) ]) , [X1(Pi(1))-X1(Pi(end)) ; Y1(Pi(1))-Y1(Pi(end)) ; Z1(Pi(1))-Z1(Pi(end)) ]))/Li ;
         
    else
        p_m = [ mean(X1(Pi(:))); mean(Y1(Pi(:))); mean(Z1(Pi(:))) ] ;
        d   = norm (cross( (p_m - [X1(Pj(1)) ; Y1(Pj(1)) ; Z1(Pj(1)) ]) , [X1(Pj(1))-X1(Pj(end)) ; Y1(Pj(1))-Y1(Pj(end)) ; Z1(Pi(1))-Z1(Pj(end)) ]))/Lj  ;
    end
    
 %% ratio of overlap ??
 
 
 %% pair label
 label_i = Linei(1,11) ;
 label_j = Linej(1,11) ; 
 
 if (label_i==1 )&&(label_j== 1)     % both discountinuty
     p_label = 'a' ;
 elseif (label_i== 2 )||(label_j==2) % at least one is unknown
     p_label = 'b' ;
 else                                % disc. and curvature
     p_label = 'c' ;    
 end
     
 
 %% average depth of lines
 
 Zm = [Z1(Pi) ; Z1(Pj)] ;
 
 %% distance from the center of image
 [row , col] = ind2sub(size(Id),[Pi(1) Pi(end) Pj(1) Pj(end)]) ;
 dc = norm([ mean(row)-size(Id,1)/2 ; mean(col)-size(Id,2)/2 ]);
 
 %% feature vector elements
    
    
 feature_vec = [ d ; ang ; max(Li,Lj) ; min(Li,Lj)/max(Li,Lj) ;  length(Pi)+length(Pj) ; p_label ; mean(Zm) ; dc ] ;
 
 
end