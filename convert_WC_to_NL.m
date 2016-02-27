% convert_WC_to_NL.m
%   converts the labels from WC's tool to Namhoon's standard by changing
%   the order of joints. 
% 
% Usage: 
%   Have the labels (.mat file). For example, 'labeled_data.mat'
%   Run the script, then it will save 'labeled_data_NL.mat'
%
% What it does:
%   label_joint_pos       -> label_joint_pos_NL
%   label_joint_pos_rel   -> label_joint_pos_rel_NL
%   label_joint_state     -> label_joint_state_NL
%   output_joint_pos      -> output_joint_pos_NL
%
% Namhoon Lee (namhoonl@andrew.cmu.edu)
%

clear; clc; close all;

load('labeled_data.mat');
nData = size(bbox_size,1);

orderNL = [1 2 3 5 7 9 11 13 4 6 8 10 12 14];       % for 14 joints
tmp = [orderNL*2-1;orderNL*2]; 
orderNLxy = tmp(:)';                                % for 28 serialized x,y

for i=1:nData
    label_joint_pos_NL{i}       = label_joint_pos{i}(orderNL, :);
    label_joint_pos_rel_NL{i}   = label_joint_pos_rel{i}(orderNL, :);
    label_joint_state_NL{i}     = label_joint_state{i}(:, orderNL);
    output_joint_pos_NL{i,1}    = output_joint_pos{i}(:, orderNLxy);
    good_img_index_NL           = good_img_index;
end

save('labeled_data_NL.mat', 'label_joint_pos_NL', 'label_joint_pos_rel_NL', ...
    'label_joint_state_NL', 'output_joint_pos_NL', 'bbox_size','good_img_index_NL');



