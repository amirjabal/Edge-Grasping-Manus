%
clc ; close all ; clear
%load('Primesense2View0710.mat')
load('datasets/Primesense_0713_10pics.mat')
cc = 	6;
%load('dep07072.mat')
manus_initial_parameters
P.mode = 'auto' ;

%%  Run algorithm
algorithm_part1
manus_pcl_process
if strcmp(P.mode,'manual')
    draw_pairs_v2(ListPair,Line_new,Ic,1) % paired lines
    pair_no  = user_selection(ListPair,Line_new,ListPoint_new, Id,P) ;
    algorithm_part2
    algorithm_part3h1
    if f_success
        algorithm_part3h2
        % Drawing the point clouds
        if P.fig_pcl
            DrawSelectedPoints(TargetPoints, TargetPoints_noshift,10,Ic,'Selected Points')
            drawPclMarkedPts(Cloud_B2, set_points, original_points, 20, 'PCL - Before and After Shifting',P)
            draw_pcl_Xaxis(Cloud_B2, LL1, LL2, 21, 'Fit Lines') % draw fit lines on the PCL
            draw_pcl(Cloud_B2, P_centerRAN, p_best, n_best, ro_best, Dir_vecRAN, 22, 'RANSAC-Point Cloud',P)
        end
    end
    clean_vars
elseif strcmp(P.mode,'auto')
    filtered_pairs = [];
    for x0=1:size(ListPair,1)
        try
            pair_no = x0 ;
            algorithm_part2
            algorithm_part3h1
            if f_success
                algorithm_part3h2
                auto_pair_selection
            end
        catch
            display(sprintf ('There was an error in computations of pair %d',pair_no))
        end
        clean_vars
        pause(0.5)
    end
    filtered_pairs
    draw_pairs_v2(ListPair,Line_new,Ic,40) % paired lines
    pause(1)
    draw_pairs_v2(ListPair(filtered_pairs,:),Line_new,Ic,41) % filtered paired lines
end

%%
%pair_no = point2pair(ListPair,Line_new,xypos,P);

%% Description
% algorithm_part1       % edge detection and transform pcl
% algorithm_part2h1     % do the shifting and check pair connections (shift all)
% algorithm_part2h2     % do the shifting and check pair connections (shift selected)
% algorithm_part3h1     % ransac fit plane , pca and corresponded pcls
% algorithm_part3h2     % assign the pose and orientation for the grasp draw pcl
% algorithm_part4       % send the point for ROS
