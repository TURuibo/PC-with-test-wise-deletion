clc
clear all

% Generate synthetic data with 5 variables
% x->z<-y
% z->a->b

num_sample = 20000;

noise = randn(num_sample,1);
x=noise;

noise = randn(num_sample,1);
y=noise;

noise = randn(num_sample,1);
z = 0.5*x+0.5*y+ noise;

noise = randn(num_sample,1);
a=0.5*z+noise;

noise = randn(num_sample,1);
b=0.5*a+noise;

data = [x,y,z,a,b];

% Experiment1: Test PC with complete data
alpha = 0.01;
max_fan_in = 4;
C=corrcoef(data);
N=num_sample;

pdag1 = wang_learn_struct_pdag_pc('cond_indep_fisher_z', 5, max_fan_in, C, N, alpha)

% Experiment2: Test PC with test-wise deletion
alpha = 0.01;
max_fan_in = 4;
% Demo1: presence of missing values doesn't influence the result of PC
z1=z;
z1(a>0) = inf;  % missing values are represented with inf
b1=b;
b1(a>0) = inf;  
data1 = [x,y,z1,a,b1];
m_vars = [3,5] ; % the index of variable with missing values
pdag2 = wang_learn_struct_pdag_pc('test_del_cond_indep_fisher_z', 5, max_fan_in, data1,m_vars, alpha)

% Demo2: presence of missing values influences the result of PC (extra edge)
x1=x;
x1(z>0) = inf;  
data2 = [x1,y,z,a,b];
m_vars = [1] ; 
pdag3 = wang_learn_struct_pdag_pc('test_del_cond_indep_fisher_z', 5, max_fan_in, data2,m_vars, alpha)

