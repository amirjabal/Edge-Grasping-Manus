
for cnt1=1:size(Line_new,1)
    if (length(Line_merged_n{cnt1})>1)&&((Line_new(cnt1,11)== 9)||(Line_new(cnt1,11)== 10))  % check if any merging happend at all
        line_num = Line_merged_n{cnt1} ;
        line_length = LineFeature(line_num,5) ;
        indx1 = find(line_length>20) ; % filter short lines
        if length(indx1)<2
            continue    % number of long lines is less than 2
        elseif length(indx1)>2
            continue    % number of long lines is larger than 2
            % ** I have to come up with a solution for this
            % part
        else            % number of large lines is 2
            gwin = [] ;
            DrawLineFeature(Line_new(cnt1,:),Ic,'Modified lines',cnt1)
            for cnt2=1:2
                win_width = 9 ;
                [wint, winp, winn] = make_RecMask(LineFeature(line_num(indx1(cnt2)),:),win_width) ;
                if Line_new(cnt1,11)== 9   % object is on the negetive side of the line
                    maskOneSide= roipoly(Id, winn(2,:), winn(1,:)) ;
                elseif Line_new(cnt1,11)==10   % object is on the positive side of the line
                    maskOneSide= roipoly(Id, winp(2,:), winp(1,:)) ;
                end
                I_marked = maskOneSide.*Gdir ;
                vec = I_marked(:) ;
                vec(vec==0)=[];
                gwin(cnt2) = mean(vec);
                 % draw_LogicalOnImage(maskOneSide,L22,'mask',cnt1+cnt2) %
                 % use for visualization of masks
            end
            if abs(gwin(1)-gwin(2))>20
                %display('break the line')
                cnt1
            end
        end
    end
end