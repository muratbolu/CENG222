
% Load statistics module for chi-square independence test
pkg load statistics;

% Define the matrix
X = [34 32 15 19; 56 58 75 71];

% Use library function
[pval, chisq, df] = chisquare_test_independence(X)
