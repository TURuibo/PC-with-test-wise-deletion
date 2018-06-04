# Test-wise PC
## Install
"Test-wise PC" is based on the work of junbai wang, MGraph.
[Installation of MGraph](https://ww2.mathworks.cn/matlabcentral/fileexchange/14635-mgraph?focused=3836964&tab=function)

## Introduction
run_demos.m: Examples: how to use PC and test-wise PC  
del.m: list-wise deletion  
find_r_var.m: find missingness indicators and their index  
test_del_cond_indep_fisher_z.m: Fisher's Z-test with test-wise deltetion   

## Call test-wise PC
We use PC framework in MGraph with our test-wise conditional independence test.  
e.g.:   
pdag = wang_learn_struct_pdag_pc('test_del_cond_indep_fisher_z', 5, max_fan_in, data,m_vars, alpha)  
pdag = wang_learn_struct_pdag_pc('cond_indep_fisher_z', 5, max_fan_in, C, N, alpha)

Notice:  
1. call function 'test_del_cond_indep_fisher_z' for PC rather than 'cond_indep_fisher_z'
2. Parameters from the fourth one are for conditional independence test, and for 'test_del_cond_indep_fisher_z', it requires original data ("data"), and the index of missingness indicatros ("m_vars").  
3. The others are the same with MGraph.   
