close all ; clc

%%
% [Gx, Gy] = imgradientxy(Id);
% [Gmag, Gdir] = imgradient(Gx, Gy);
% [BW41,~] = edge(Gdir,'canny',0.3);
% [BW42,~] = edge_modified(Gdir,'canny',0.3);
% 
% 
% figure;imshow(BW41)
% figure;imshow(BW42)



%%

close all


% case 1 : mirros left half to the right half
index1=find(Gdir>90) ;
index2=find(Gdir<-90) ; 
Gdir1 = Gdir ; 
Gdir1(index1) = 180-Gdir1(index1);
Gdir1(index2) = -(180+Gdir1(index2));

%case 2 : mirrors bottom half to the top half
Gdir2 = Gdir ; 
index3= find(Gdir2<0) ;
Gdir2(index3) = abs(Gdir(index3));

[BW30,~] = edge(Gdir,'canny',0.3);
[BW41,~] = edge(Gdir1,'canny',0.55);
[BW42,~] = edge(Gdir2,'canny',0.55);
L31= label2rgb(fix(180+Gdir));
L32= label2rgb(fix(90+Gdir1));
L33= label2rgb(fix(Gdir2));
%figure;imshow(L31)
figure;imshow(L32)
figure;imshow(L33)


BW43 = or(BW41,BW42) ; 

figure;imshow(BW30);title('Gdir')
figure;imshow(BW43);title('Gdir new')



