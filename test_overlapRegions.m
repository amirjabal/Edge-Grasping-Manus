
% objective: find overlapping regions of a pair (based on their projection on the bisector line)

% step1: find slope of the bisector (mb)
% step2: find slope of orthogonal of the bisector (mn)
% step3:
% option1: create a mask on the object side of each line and find the
% overlap
% option2: form lines with the slope of mn and include end-points of
% pairs. Then intersect them with the pairs.

% bugs: it does not work when the lines are vertical



lineI = Line_new(ListPair(3,1),:) ;
lineJ = Line_new(ListPair(3,2),:) ;

centerI = 0.5*[lineI(1,1)+lineI(1,3), lineI(1,2)+lineI(1,4)];
centerJ = 0.5*[lineJ(1,1)+lineJ(1,3), lineJ(1,2)+lineJ(1,4)];
centerB = 0.5*(centerI+centerJ) ;

beta = 0-90 ; 
width = 20 ;

alphaBisec = 0.5*(lineI(1,7)+lineJ(1,7)) ;
alphaOrthog = alphaBisec + beta ; % ***************** bug of code
mOrthog = tand(alphaOrthog) ;

deltaX = sqrt(width^2/(mOrthog^2+1));
deltaY = mOrthog*sqrt(width^2/(mOrthog^2+1));

if lineI(1,12)==1 % line is considered vertical
    %line I
    signDelta = sign(centerB(2)-centerI(2)) ;
    pI1 = [lineI(1),lineI(2)] + signDelta*[deltaY, deltaX] ;
    pI2 = [lineI(3),lineI(4)] + signDelta*[deltaY, deltaX] ;
    pJ1 = [lineJ(1),lineJ(2)] - signDelta*[deltaY, deltaX] ;
    pJ2 = [lineJ(3),lineJ(4)] - signDelta*[deltaY, deltaX] ;
else  % line is considered horizontal
    signDelta = sign(centerB(1)-centerI(1)) ;
    pI1 = [lineI(1),lineI(2)] + signDelta*[deltaY, deltaX] ;
    pI2 = [lineI(3),lineI(4)] + signDelta*[deltaY, deltaX] ;
    pJ1 = [lineJ(1),lineJ(2)] - signDelta*[deltaY, deltaX] ;
    pJ2 = [lineJ(3),lineJ(4)] - signDelta*[deltaY, deltaX] ;
    
end

winI = [lineI(1), lineI(3), pI2(1), pI1(1);...
    lineI(2), lineI(4), pI2(2) , pI1(2)] ;
winJ = [lineJ(1), lineJ(3), pJ2(1), pJ1(1);...
    lineJ(2), lineJ(4), pJ2(2) , pJ1(2)] ;

maskI = roipoly(Id, winI(2,:), winI(1,:)) ;
maskJ = roipoly(Id, winJ(2,:), winJ(1,:)) ;

BI = imoverlay(Ic,maskI,'red');
BJ = imoverlay(BI,maskJ,'blue');


figure;imshow(BJ)
