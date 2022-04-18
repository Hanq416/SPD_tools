%ricoh theta z1 #1, CRF
%Red
r = [2.365991e-03,1.493584e-01,7.752696e-01,-2.007615,2.080621];
g = [2.754270e-03,1.359830e-01,8.005237e-01,-1.998561,2.059300];
b = [3.191953e-03,1.159051e-01,1.054524,-2.767564,2.593943];
%Theta Z1 crf
X = 0:255;X = X./255; range = 0:255;
R = r(5).*X.^(4) + r(4).*X.^(3) + r(3).*X.^(2)+r(2).*X + r(1); %deg 4 CRF R photosphere
G = g(5).*X.^(4) + g(4).*X.^(3) + g(3).*X.^(2)+g(2).*X + g(1); %deg 4 CRF G photosphere
B = b(5).*X.^(4) + b(4).*X.^(3) + b(3).*X.^(2)+b(2).*X + b(1); %deg 4 CRF B photosphere

%plot(X,R); 
%hold on;
%scatter(x,y); 
%axis equal; xlim([0 1]);ylim([0.7 1]);

%{
figure,
hold on
plot(range,R,'--r','LineWidth',2);
plot(range,G,'--g','LineWidth',2);
plot(range,B,'--b','LineWidth',2);
ylabel('Relative Radiance');
xlabel('Image Intensity');
title('Camera Response Function THETA Z1');
grid on
axis('tight')
legend('R-channel','G-channel','B-cchannel','Location','southeast')
%}
%%
figure,
hold on
plot(range,R,'-r','LineWidth',2);
plot(range,G,'--g','LineWidth',2);
plot(range,B,'-.b','LineWidth',2);
hold off;
ylabel('Relative Radiance');
xlabel('Pixel Intensity');
title('Camera Response Function THETA Z1');
grid on;
axis('tight');
xlim([0 255]);ylim([0 1]);
legend('R-channel','G-channel','B-channel');
legend('Location','southeast');
% set(gca,'color','black');
