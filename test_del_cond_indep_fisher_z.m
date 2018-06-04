function [CI, r, p] = test_del_cond_indep_fisher_z(X, Y, S, data,m_vars, alpha)
% COND_INDEP_FISHER_Z Test with test-wise deletion if X indep Y given Z using Fisher's Z test
% CI = test_del_cond_indep_fisher_z(X, Y, S, data,m_vars, alpha)
%
% data: the original data
% m_vars: the index of partially observable variables
% alpha is the significance level (default: 0.05)
%
% See p133 of T. Anderson, "An Intro. to Multivariate Statistical Analysis", 1984

% Get index of variables in the conditional independence test
test_vars = [X,Y,S]; 

% Test whether the testing variables contain missing values
if contain_missing(m_vars, test_vars)
    % If containing missing value, 
    % we apply list-wise deletion for current testing variables, 
    % named "test-wise deletion"
    
    data = data(:,test_vars);
    % Test-wise deletion 
    vir_data = del(data);
    [num_sam,num_var] = size(vir_data);   
    C = corrcoef(vir_data);   
else 
    % CI is testing variables without missing
    % Then do nothing 
    data = data(:,test_vars);% Get the data we are testing 
    [num_sam,num_var] = size(data);
    C = corrcoef(data);
end
N = num_sam;
X = 1;
Y = 2;
S = 3:num_var;  % when num_var = 2, S = "empty array"
    
if nargin < 6, alpha = 0.05; end

r = partial_corr_coef(C, X, Y, S);
%added jbw
z = 0.5*log( abs(1+r)/abs(1-r) );
%end added
z0 = 0;

%if sample size N too small ??Oct 12.2003
W = sqrt(N - length(S) - 3)*(z-z0); % W ~ N(0,1)
%cutoff = norminv(1 - 0.5*alpha); % P(|W| <= cutoff) = 0.95
cutoff = mynorminv(1 - 0.5*alpha); % P(|W| <= cutoff) = 0.95
if abs(W) < cutoff
  CI = 1;
%   write_log(S, X, Y)
else % reject the null hypothesis that rho = 0
  CI = 0;
end

%p = normcdf(W);
p = mynormcdf(W);
end


function missing_state = contain_missing(missing_var, test_var)
% test whether the CI test contain missing variable
% input: 
%   missing_var: a number 
%   test_var: a array 
%output:
%   missing_state: True or false
    if isempty(intersect(missing_var, test_var))
        missing_state = false;
    else
        missing_state = true;
    end
end


