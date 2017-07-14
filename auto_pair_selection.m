% based on the following features, filters the pairs

error_ransac = error_plane/size(set_points,1)*100 ; 
flag1 = flag_orientation ;
d_pair = dis_L1L2_3d ;
n1 = size(set_points,1) ;
n2 = size(set_points2,1) ;
n3 = size(set_points3,1) ;

feat_vec(x0,:) = [error_ransac n1 n2 n3 d_pair] ;
if (error_ransac<0.1) && (n1>50) && (n2>5) && (n3>5) && (d_pair>0.02) && (strcmp(flag1,'side'))
    display(sprintf('pair number %d passed', pair_no))
    filtered_pairs = [filtered_pairs , pair_no] ;
else
    display(sprintf('pair number %d is dropped', pair_no))
end