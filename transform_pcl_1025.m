
function [Cloud_B] = transform_pcl_1025(P,Id,Ixyz)


% point cloud in kinect frame

if P.flag_d_stream
    [Cloud_K,~] = depthToCloud_v2(Id,P.Cons_Cam, [1 1],P.center) ; %center = [imw/2 imh/2];
else
    
    % remove the out of range data from point cloud
    % modify the values which construct by holefilter
    
    
    if P.fillhole && ~P.flag_d_stream
    I_fill = zeros(size(Ixyz)) ; 
    I_fill(P.zone(1):P.zone(2),P.zone(3):P.zone(4),:) = Ixyz(P.zone(1):P.zone(2),P.zone(3):P.zone(4),:) ;
    [row, col] = find(isnan(I_fill(:,:,3))) ;
    
    for cnt1 = 1:length(row)
        
        I_fill(row(cnt1),col(cnt1),1) = Id(row(cnt1),col(cnt1))*(col(cnt1)-P.center(1))/P.Cons_Cam/1000 ;
        I_fill(row(cnt1),col(cnt1),2) = Id(row(cnt1),col(cnt1))*(row(cnt1)-P.center(2))/P.Cons_Cam/1000 ;
        I_fill(row(cnt1),col(cnt1),3) = Id(row(cnt1),col(cnt1))/1000 ;
        
    end
    
    I_fill2 = nan(size(Ixyz)) ;
    I_fill2(P.zone(1):P.zone(2),P.zone(3):P.zone(4),:)=I_fill(P.zone(1):P.zone(2),P.zone(3):P.zone(4),:) ;
    
    Ixyz = I_fill2 ; 
    end
    

    Itt = nan(size(Ixyz)) ;
    Itt(P.zone(1):P.zone(2),P.zone(3):P.zone(4),:)=Ixyz(P.zone(1):P.zone(2),P.zone(3):P.zone(4),:);
    
    [row1,col1] = find(Id>P.hhd) ;
    [row2,col2] = find(0<Id&Id<P.lld) ;
    %     Itt([row1;row2],[col1;col2],:) = nan ;
    Itt(row1,col1,:)= nan ;
    Itt(row2,col2,:)= nan ;
    Ixyz = Itt ;
    
    
    
    Cloud_K(:,:,1) = Ixyz(:,:,3) ; % 1 3
    Cloud_K(:,:,2) = Ixyz(:,:,1) ; % 2 1
    Cloud_K(:,:,3) = Ixyz(:,:,2) ; % 3 2
end

Cloud_Zk = -Cloud_K(:,:,1) ; Cloud_Xk = Cloud_K(:,:,2) ; Cloud_Yk = -Cloud_K(:,:,3) ;


% point cloud in base frame (rot and trans)
%invq = quatinv(P.quat) ;
% invq = [0.2032 0.3220 -0.7851 0.4885];
% for rotation matrix
Cloud_temp = reshape(Cloud_Xk(:),1,480*640);
Cloud_temp(2,:) = reshape(Cloud_Yk(:),1,480*640);
Cloud_temp(3,:) = reshape(Cloud_Zk(:),1,480*640);

% Cloud_Bt = quatrotate(invq,[Cloud_Xk(:) Cloud_Yk(:) Cloud_Zk(:)]) ;
Cloud_Bt = P.rot'*P.rot2*Cloud_temp ;
% Cloud_Bt = [Cloud_Bt(:,1)+P.baseloc(1)  Cloud_Bt(:,2)+P.baseloc(2)  Cloud_Bt(:,3)+P.baseloc(3) ] ;
Cloud_Bt = [Cloud_Bt(1,:)+P.baseloc(1) ; Cloud_Bt(2,:)+P.baseloc(2) ; Cloud_Bt(3,:)+P.baseloc(3) ]' ;

Cloud_B(:,:,1) = reshape(Cloud_Bt(:,1),size(Id)) ;
Cloud_B(:,:,2) = reshape(Cloud_Bt(:,2),size(Id)) ;
Cloud_B(:,:,3) = reshape(Cloud_Bt(:,3),size(Id)) ;


end
