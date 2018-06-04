function data_t = del(data)
% List-wise deletion
% input:
%   data: data included fully and paritally observable variables
% output:
%   data: data with list-wise deletion
    [R, R_ind]=find_r_var(data);
    if length(R_ind) ~= 0
        ind = sum(R,2)==0;
        data_t = data(ind,:);
    else
        data_t = data;
    end
end