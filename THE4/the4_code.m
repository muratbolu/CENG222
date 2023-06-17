
% Load statistics module for inverse standard normal distribution
pkg load statistics;

% Define the constants
poissLambdaBulk = 50;
poissLambdaContainer = 40;
poissLambdaOil = 25;

alphaBulk = 60;
alphaContainer = 100;
alphaOil = 120;

gamLambdaBulk = 0.1;
gamLambdaContainer = 0.05;
gamLambdaOil = 0.02;

weightThreshold = 300000;

alphaProbability = 1 - 0.98;
epsilonDifference = 0.03;
% Calculate Monte Carlo study size
z_alpha = norminv(1 - alphaProbability/2);
sizeMonteCarlo = ceil(0.25 * (z_alpha/epsilonDifference)^2);

% Function to generate poisson and gamma random variables and calculate total cargo
function result = generateTotalSize(poissLambda, alpha, gamLambda)
  U = rand;
  i = 0;
  F = exp(-poissLambda);
  while (F < U);
    F += exp(-poissLambda) * poissLambda^i / gamma(i+1);
    i += 1;
  endwhile
  result = 0;
  for j = 1:i;
    result += sum(-1/gamLambda * log(rand(alpha, 1)));
  endfor
endfunction

% Number of times total cargo exceeded threshold
cargoExceeds = 0;
% Vector of total cargo sizes
sums = [];

for i = 1:sizeMonteCarlo;
  sumBulk = generateTotalSize(poissLambdaBulk, alphaBulk, gamLambdaBulk);
  sumContainer = generateTotalSize(poissLambdaContainer, alphaContainer, gamLambdaContainer);
  sumOil = generateTotalSize(poissLambdaOil, alphaOil, gamLambdaOil);
  sumAll = sumBulk + sumContainer + sumOil;
  sums = [sums, sumAll]; % Append to sums vector
  cargoExceeds += (sumAll > weightThreshold);
endfor

% Probability that the total cargo exceeded the threshold
probabilityExceeds = cargoExceeds/sizeMonteCarlo;
% X is average daily total cargo
X = mean(sums);
% Standard deviation of X
stdDevX = std(sums);

fprintf("Estimated probability: %.3f\nExpected weight: %.2f\nStandard deviation: %.2f\n", probabilityExceeds, X, stdDevX);
