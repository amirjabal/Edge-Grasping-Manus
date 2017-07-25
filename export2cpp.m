

% [yaw, pitch, roll] = dcm2angle( Dir_vecRAN);
[yaw, pitch, roll] = dcm2angle( [Dir_ZZ -Dir_YY -Dir_XX ]);
yaw = yaw/pi*180
% if abs(yaw)>90
%     yaw = yaw+180;
% end
% yaw
pitch = pitch/pi*180
% roll = roll/pi*180
roll = 180
fid=fopen('C:\\MANUS\\CommonSpace\\Assistant\\requestedPosition.txt','w');
fprintf(fid, '%f  \n', [1000*P_centerRAN' yaw pitch roll]);
fclose(fid);

fid2=fopen('C:\\MANUS\\CommonSpace\\Assistant\\Mflag.txt','w');
fprintf(fid2, '%f  \n', 1);
fclose(fid2);

pause(10)

fid2=fopen('C:\\MANUS\\CommonSpace\\Assistant\\Mflag.txt','w');
fprintf(fid2, '%f  \n', 0);
fclose(fid2);

