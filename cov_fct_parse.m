function std_gt = cov_fct_parse(gt,mode)
% the conversion function which convert Namhoon's keypoints order or
% Wei-chiu's keypoint order to the observer-centric order used on DPM
% gt : struct which has 'point' field with 14 points (in Namhoon order or in
% Wei-Chiu order) and 'state' field
% mode : 'n' for Namhoon order; 'w' for Wei-Chiu order
% std_gt : observer-centric order used on DPM
std_gt=gt;
for i=1:length(gt)
    if mode=='n'
        if gt(i).point(5,1)<gt(i).point(11,1)
            std_gt(i).point(7,:)=gt(i).point(5,:);
            std_gt(i).state(7)=gt(i).state(5);
            std_gt(i).point(8,:)=gt(i).point(4,:);
            std_gt(i).state(8)=gt(i).state(4);
            std_gt(i).point(9,:)=gt(i).point(3,:);
            std_gt(i).state(9)=gt(i).state(3);
            std_gt(i).point(10,:)=gt(i).point(9,:);
            std_gt(i).state(10)=gt(i).state(9);
            std_gt(i).point(11,:)=gt(i).point(10,:);
            std_gt(i).state(11)=gt(i).state(10);
            std_gt(i).point(12,:)=gt(i).point(11,:);
            std_gt(i).state(12)=gt(i).state(11);
        else
            std_gt(i).point(7,:)=gt(i).point(11,:);
            std_gt(i).state(7)=gt(i).state(11);
            std_gt(i).point(8,:)=gt(i).point(10,:);
            std_gt(i).state(8)=gt(i).state(10);
            std_gt(i).point(9,:)=gt(i).point(9,:);
            std_gt(i).state(9)=gt(i).state(9);
            std_gt(i).point(10,:)=gt(i).point(3,:);
            std_gt(i).state(10)=gt(i).state(3);
            std_gt(i).point(11,:)=gt(i).point(4,:);
            std_gt(i).state(11)=gt(i).state(4);
            std_gt(i).point(12,:)=gt(i).point(5,:);
            std_gt(i).state(12)=gt(i).state(5);
        end
        
        if gt(i).point(14,1)<gt(i).point(8,1)
            std_gt(i).point(1,:)=gt(i).point(14,:);
            std_gt(i).point(2,:)=gt(i).point(13,:);
            std_gt(i).point(3,:)=gt(i).point(12,:);
            std_gt(i).point(4,:)=gt(i).point(6,:);
            std_gt(i).point(5,:)=gt(i).point(7,:);
            std_gt(i).point(6,:)=gt(i).point(8,:);
            std_gt(i).state(1)=gt(i).state(14);
            std_gt(i).state(2)=gt(i).state(13);
            std_gt(i).state(3)=gt(i).state(12);
            std_gt(i).state(4)=gt(i).state(6);
            std_gt(i).state(5)=gt(i).state(7);
            std_gt(i).state(6)=gt(i).state(8);
        else
            std_gt(i).point(1,:)=gt(i).point(8,:);
            std_gt(i).point(2,:)=gt(i).point(7,:);
            std_gt(i).point(3,:)=gt(i).point(6,:);
            std_gt(i).point(4,:)=gt(i).point(12,:);
            std_gt(i).point(5,:)=gt(i).point(13,:);
            std_gt(i).point(6,:)=gt(i).point(14,:);
            std_gt(i).state(1)=gt(i).state(8);
            std_gt(i).state(2)=gt(i).state(7);
            std_gt(i).state(3)=gt(i).state(6);
            std_gt(i).state(4)=gt(i).state(12);
            std_gt(i).state(5)=gt(i).state(13);
            std_gt(i).state(6)=gt(i).state(14);
        end
        std_gt(i).point(13,:)=gt(i).point(2,:);
        std_gt(i).point(14,:)=gt(i).point(1,:);
        std_gt(i).state(13)=gt(i).state(2);
        std_gt(i).state(14)=gt(i).state(1);
    elseif mode=='w'
        if gt(i).point(8,1)<gt(i).point(7,1)
            std_gt(i).point(7,:)=gt(i).point(8,:);
            std_gt(i).state(7)=gt(i).state(8);
            std_gt(i).point(8,:)=gt(i).point(6,:);
            std_gt(i).state(8)=gt(i).state(6);
            std_gt(i).point(9,:)=gt(i).point(4,:);
            std_gt(i).state(9)=gt(i).state(4);
            std_gt(i).point(10,:)=gt(i).point(3,:);
            std_gt(i).state(10)=gt(i).state(3);
            std_gt(i).point(11,:)=gt(i).point(5,:);
            std_gt(i).state(11)=gt(i).state(5);
            std_gt(i).point(12,:)=gt(i).point(7,:);
            std_gt(i).state(12)=gt(i).state(7);
        else
            std_gt(i).point(7,:)=gt(i).point(7,:);
            std_gt(i).state(7)=gt(i).state(7);
            std_gt(i).point(8,:)=gt(i).point(5,:);
            std_gt(i).state(8)=gt(i).state(5);
            std_gt(i).point(9,:)=gt(i).point(3,:);
            std_gt(i).state(9)=gt(i).state(3);
            std_gt(i).point(10,:)=gt(i).point(4,:);
            std_gt(i).state(10)=gt(i).state(4);
            std_gt(i).point(11,:)=gt(i).point(6,:);
            std_gt(i).state(11)=gt(i).state(6);
            std_gt(i).point(12,:)=gt(i).point(8,:);
            std_gt(i).state(12)=gt(i).state(8);
        end
        
        if gt(i).point(14,1)<gt(i).point(13,1)
            std_gt(i).point(1,:)=gt(i).point(14,:);
            std_gt(i).point(2,:)=gt(i).point(12,:);
            std_gt(i).point(3,:)=gt(i).point(10,:);
            std_gt(i).point(4,:)=gt(i).point(9,:);
            std_gt(i).point(5,:)=gt(i).point(11,:);
            std_gt(i).point(6,:)=gt(i).point(13,:);
            std_gt(i).state(1)=gt(i).state(14);
            std_gt(i).state(2)=gt(i).state(12);
            std_gt(i).state(3)=gt(i).state(10);
            std_gt(i).state(4)=gt(i).state(9);
            std_gt(i).state(5)=gt(i).state(11);
            std_gt(i).state(6)=gt(i).state(13);
        else
            std_gt(i).point(1,:)=gt(i).point(13,:);
            std_gt(i).point(2,:)=gt(i).point(11,:);
            std_gt(i).point(3,:)=gt(i).point(9,:);
            std_gt(i).point(4,:)=gt(i).point(10,:);
            std_gt(i).point(5,:)=gt(i).point(12,:);
            std_gt(i).point(6,:)=gt(i).point(14,:);
            std_gt(i).state(1)=gt(i).state(13);
            std_gt(i).state(2)=gt(i).state(11);
            std_gt(i).state(3)=gt(i).state(9);
            std_gt(i).state(4)=gt(i).state(10);
            std_gt(i).state(5)=gt(i).state(12);
            std_gt(i).state(6)=gt(i).state(14);
        end
        std_gt(i).point(13,:)=gt(i).point(2,:);
        std_gt(i).point(14,:)=gt(i).point(1,:);
        std_gt(i).state(13)=gt(i).state(2);
        std_gt(i).state(14)=gt(i).state(1);
        
    end
end
    
    
    
