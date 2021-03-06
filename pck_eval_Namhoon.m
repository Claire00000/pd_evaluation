 function [pck1,pck2,pck3] = pck_eval_Namhoon(ca,gt,thresh,mode,standard)
% the function is used to calculate the pck score of body with and without
% occlude part
% ca    : struct which contains 'point' field with test 14 points
% gt    : struct which contains 'point' field with ground truth 14 points
%         ;'state' field which contains the occlusion state of that part
%         1 for visible; 2 for self-occlude 3 for other-occlude; 'quality'
%         field which contains the quality of the instance, 1 for good, 0 for bad;
% thresh: scale the threshold
% mode  : 'u' for only calculate upper body(8 points),'l' for only calculate
%          lower body,'a' for calculate the whole body
% standard: 'h' for using head size as standard,'b'for using bounding box
%          as standard
% pck1  : score including both other-occlude parts and self-occlude parts
% pck2  : score including self-occlude and excluding other-occlude
% pck3  : score excluding both self-occlude and other-occlude


if nargin<5
    standard='h';
end

assert(numel(ca) == numel(gt));
point_num=size(gt(1).point,1);

dist=zeros(point_num,1);
scale=zeros(1,1);
state1=zeros(point_num,1); % state num 1 for visiable and self-occlude 
state2=zeros(point_num,1); % state num 1 for visiable
j=1;
for i = 1:length(gt)
    if gt(i).quality
        dist(:,j) = sqrt(sum((ca(i).point-gt(i).point).^2,2));
        state1(:,j)=gt(i).state-2<=0;
        state2(:,j)=gt(i).state-2<0;
        if standard=='b'
            scale(1,j)=max(max(gt(i).point,[],1)-min(gt(i).point,[],1)+2);
        elseif standard=='h'
            scale(1,j)=norm(gt(i).point(1,:)-gt(i).point(2,:));
        end
        j=j+1;
    end
end

scale=repmat(scale,point_num,1);
matrix=dist<=thresh*scale;

if mode=='u'
    upper_matrix=[matrix(1:5,:);matrix(9:11,:)];
    upper_state1=[state1(1:5,:);state1(9:11,:)];
    upper_state2=[state2(1:5,:);state2(9:11,:)];
    part_pck=mean(upper_matrix,2);
    pck1=mean(part_pck*100);
    pck2=mean((sum(upper_matrix.*upper_state1,2)./sum(upper_state1,2))*100);
    pck3=mean((sum(upper_matrix.*upper_state2,2)./sum(upper_state2,2))*100);
elseif mode=='l'
    lower_matrix=[matrix(6:8,:);matrix(12:14,:)];
    lower_state1=[state1(6:8,:);state1(12:14,:)];
    lower_state2=[state2(6:8,:);state2(12:14,:)];
    part_pck=mean(lower_matrix,2);
    pck1=mean(part_pck*100);
    pck2=mean((sum(lower_matrix.*lower_state1,2)./sum(lower_state1,2))*100);
    pck3=mean((sum(lower_matrix.*lower_state2,2)./sum(lower_state2,2))*100);
else
    part_pck=mean(matrix,2);
    pck1=mean(part_pck*100);
    pck2=mean((sum(matrix.*state1,2)./sum(state1,2))*100);
    pck3=mean((sum(matrix.*state2,2)./sum(state2,2))*100);
end
