
pkg load statistics;

N = 1000;
mean = 175;
std_dev = 7;

heights = randn(N, 1);
heights *= std_dev;
heights += mean;

hist(heights);
print("hist", "-dpng");

x = 150:0.1:200;
hold off;
plot(x, normpdf(x, mean, 6), ";\\sigma = 6;");
hold on;
plot(x, normpdf(x, mean, 7), ";\\sigma = 7;");
plot(x, normpdf(x, mean, 8), ";\\sigma = 8;");
print("plot", "-dpng");
