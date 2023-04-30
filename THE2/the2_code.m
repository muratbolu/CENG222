
% Load statistics module for normal probability density function
pkg load statistics;

% Define constants
N = 1000;
mean = 175;
std_dev = 7;

% Generate heights as a column vector
heights = randn(N, 1);
heights *= std_dev;
heights += mean;

% Create and print the histogram of heights
hist(heights, 10);
print("the2_hist", "-dpng");

% Create and print the normal PDF's with various standard deviations
x = 150:0.1:200;
hold off;
plot(x, normpdf(x, mean, 6), ";\\sigma = 6;");
hold on;
plot(x, normpdf(x, mean, 7), ";\\sigma = 7;");
plot(x, normpdf(x, mean, 8), ";\\sigma = 8;");
print("the2_plot", "-dpng");

% Generate heights as a 150x1000 matrix
heights = randn(150, N);
heights *= std_dev;
heights += mean;

% Filter heights and sum the successes
heights = (heights > 170) & (heights < 180);
heights = sum(heights);

% Calculate probabilities
p1 = sum(heights > 67.5)/N
p2 = sum(heights > 75)/N
p3 = sum(heights > 82.5)/N
