%ricoh theta z1 #1, vignetting correction
%Hankun Li, University of Kansas
clear all;
%f5.6
%lens #1 (front)

x = [0,14.6,30.5,44.7,60.1,74.7,82.8,90]; x = x'; x = x./90;
y = [76.1,75.8,75.5,75.4,72.8,71.6,70.1,65.5];y = y';y = y./max(y);
%{
%lens #2 (back)
x = [0,15.1,29.6,44.2,60.7,74.1,83.4,90]; x = x'; x = x./90;
y = [75.6,75.3,75.4,75,73,71.4,70.6,67.8];y = y';y = y./max(y);
%}

%f3.5
%lens #1 (front)
%{
x = [0,14.7,30.2,44.8,60.5,74.1,82.2,90]; x = x'; x = x./90;
y = [75.1,74.8,74.5,74.2,71.5,70.2,67.1,62.5];y = y';y = y./max(y);

%lens #2 (back)
x = [0,15.2,29.7,44.5,60.1,74.5,83.7,90]; x = x'; x = x./90;
y = [75.2,74.3,73.9,73.5,71.2,69.8,66.8,61.2];y = y';y = y./max(y);
%}

%f2.1
%lens #1 (front)
%{
x = [0,14.6,30.5,44.7,60.1,74.7,82.8,90]; x = x'; x = x./90;
y = [74.7,74.5,74.1,72.8,70.8,67.1,64.1,58.5];y = y';y = y./max(y);

%lens #2 (back)
x = [0,15.2,29.5,44.5,60.3,74.5,83.7,90]; x = x'; x = x./90;
y = [74.3,74.1,73.9,72.3,70.1,66.5,63.3,56.9];y = y';y = y./max(y);
%}

%curve fitting
p = polyfit(x,y,3); %polynomial!

%
X = linspace(0,1,20);
% Y = p(1).*X.^(2)+p(2).*X + p(3); %deg 2
Y = p(1).*X.^(3)+p(2).*X.^(2)+p(3).*X+p(4); %deg 3
% Y = p(1).*X.^(4) + p(2).*X.^(3) + p(3).*X.^(2)+p(4).*X + p(5); %deg 4
% Y = p(1).*X.^(5) + p(2).*X.^(4) + p(3).*X.^(3) + p(4).*X.^(2) + p(5).*X + p(6); %deg 5
plot(X,Y,'-r','LineWidth',2); hold on;
grid on; axis('tight')
ylabel('Vignetting Correction Factor');
xlabel('Relative Pixel Distance');
title('Vignetting Correction Curve of THETA Z1 (Front)');
scatter(x,y); axis equal; xlim([0 1]);ylim([0.6 1]);
legend('VC curve','Source Data Point','Location','southeast')
peval = polyval(p,x);
SStot = sum((y - mean(y)).^2);
SSres = sum((y - peval).^2);
r2 = 1 - SSres/SStot;

% I = rgb2gray(imread('0d.JPG'));

%{
%pearson coef:
eval1(:,1) = x; eval2(:,1) = x;
eval1(:,2) = y; eval2(:,2) = peval;
pc = corrcoef(eval1,eval2);
%}

