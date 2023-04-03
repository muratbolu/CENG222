
N = 1000;

% F is the first iteration where we roll one die of each color
F = rand(3, N);
F = F.*[6; 8; 10];
F = ceil(F);
for i = 1:N
  F(:,i) = getValues(F(:,i));
end
F = sum(F);

% S is the second iteration where we roll blue die thrice
S = rand(3, N);
S = S.*[6; 6; 6];
S = ceil(S);
S = sum(S);

% isBigger is the 1 x N matrix with binary outcomes
isBigger = (S > F);

% Let F and S be the total average and isBigger the percentage
% of times S was bigger than F
F = sum(F)/N;
S = sum(S)/N;
isBigger = sum(isBigger)/length(isBigger)*100;

printf("First option: %.2f\nSecond option: %.2f\
\nPercentage of cases: %2.2f%%\n", F, S, isBigger)

function out = getValues(x)
  b = x(1); y = x(2); r = x(3);
  b = [1 2 3 4 5 6](1, b);
  y = [1 1 1 3 3 3 4 8](1, y);
  r = [2 2 2 2 2 3 3 4 4 6](1, r);
  out = [b; y; r];
endfunction
