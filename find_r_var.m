function [R, R_ind]=find_r_var(data)
% Find missingness indicators of variables and their index 
% input: 
%   data: data included fully and paritally observable variables
%output:
%   R: a 2D array. 
%       Rows represent different data samples, 
%       and columns represent different variables.
%       "1" represents missing values, and "0" represents no missing value.
%   R_ind: the index of variables with missing values 
    [num_sam, num_var] = size(data);
    count = 1;
    R = zeros(num_sam,1);
    for i = 1:num_var
        if ismember(inf, data(:,i))
            R(:,count) = data(:,i) == inf;
            R_ind(count) = i;
            count = count + 1;
        end
    end  
end