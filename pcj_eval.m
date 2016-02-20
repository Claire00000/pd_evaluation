function [pcj1,pcj2,pcj3] = pcj_eval(ca,gt,thresh,mode)
% the function is used to calculate the pcj score of body with and without
% occlude part
% ca    : struct which contains 'point' field with test 14 points
% gt    : struct which contains 'point' field with ground truth 14 points
%         ;'state' field which contains the occlusion state of that part
%         1 for visible; 2 for self-occlude 3 for other-occlude; 'quality'
%         field which contains the quality of the instance, 1 for good, 0 for bad;
% thresh: scale the threshold
% mode  : 'u' for only calculate upper body(8 points),'l' for only calculate
%          lower body,'a' for calculate the whole body
% pcj1  : score including both other-occlude parts and self-occlude parts
% pcj2  : score including self-occlude and excluding other-occlude
% pcj3  : score excluding both self-occlude and other-occlude

if nargin<5
    mode='a';
end

assert(numel(ca) == numel(gt));
point_num=size(gt(1).point,1);

dist=zeros(point_num,1);
diameter=zeros(1,1);
state1=zeros(point_num,1); % state num 1 for visiable and self-occlude 
state2=zeros(point_num,1); % state num 1 for visiable
j=1;
for i=1:length(gt)
    if gt(i).quality
        dist(:,j) = sqrt(sum((ca(i).point-gt(i).point).^2,2));
        diameter(1,j)=(sqrt(sum((gt(i).point(9,:)-gt(i).point(4,:)).^2,2))+...
            sqrt(sum((gt(i).point(3,:)-gt(i).point(10,:)).^2,2)))/2;
        state1(:,j)=gt(i).state-2<=0;
        state2(:,j)=gt(i).state-2<0;
        j=j+1;
    end
end

diameter=repmat(diameter,point_num,1);
matrix=dist<=thresh*diameter;

if mode=='u'
    part_pcj=mean(matrix(1:8,:),2);
    pcj1=mean(part_pcj*100);
    pcj2=mean((sum(matrix(1:8,:).*state1(1:8,:),2)./sum(state1(1:8,:),2))*100);
    pcj3=mean((sum(matrix(1:8,:).*state2(1:8,:),2)./sum(state2(1:8,:),2))*100);
elseif mode=='l'
    part_pcj=mean(matrix(9:14,:),2);
    pcj1=mean(part_pcj*100);
    pcj2=mean((sum(matrix(9:14,:).*state1(9:14,:),2)./sum(state1(9:14,:),2))*100);
    pcj3=mean((sum(matrix(9:14,:).*state2(9:14,:),2)./sum(state2(9:14,:),2))*100);
else
    part_pcj=mean(matrix,2);
    pcj1=mean(part_pcj*100);
    pcj2=mean((sum(matrix.*state1,2)./sum(state1,2))*100);
    pcj3=mean((sum(matrix.*state2,2)./sum(state2,2))*100);
end
    
    
    