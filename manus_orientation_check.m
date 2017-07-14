
%% flipping the direction of the ransac plane if it's necessary 
% and determining if the grasp is top/side grasping.

vec_x = [1 ; 0 ; 0] ; %camera's x axis (points forward)
vec_x_b = P.rot'*P.rot2*vec_x ; %

n_test = n_best ; %copy of n_b
theta10 = acosd(dot(n_test,vec_x_b)/(norm(n_test)*norm(vec_x_b))) ; 


if theta10>90
    Dir_ZZ = -n_test;
else
    Dir_ZZ = n_test ; 
end

vec_z_b = [0 ; 0 ; 1] ; % base z axis (points up)
theta20 = acosd(dot(n_test,vec_z_b)/(norm(n_test)*norm(vec_z_b))) ; 

if (theta20>45) && (theta20<135)
    flag_orientation = 'side' ;
else
    flag_orientation = 'top' ;
end

%theta10
%theta20
%flag_orientaion
