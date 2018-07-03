%实现 Butterworth 滤波器
clear;clc;

%% 读取图像
img = imread('data\origin1.png');
if size(img, 3) == 3
    img = rgb2gray(img);
end
figure('Name', '原图');
imshow(img);

%% 快速傅里叶变换
IMG = fft2(img);                            %进行傅里叶变换
% figure('Name', '原图傅里叶谱');
% imshow(log(abs(IMG) + 1), []);

%% 频域图像居中
Guv = fftshift(IMG);                        %对傅里叶变换的结果进行居中处理
% figure('Name', '原图平移后傅里叶谱');
% mesh(abs(Guv));
figure('Name', '原图平移后傅里叶谱');
imshow(log(abs(Guv) + 1), []);

%% Butterworth 低通滤波器
lengthOfSide = size(img, 1);
halfLengthOfSideCeil = ceil(lengthOfSide / 2);
halfLengthOfSideFloor = floor(lengthOfSide / 2);
Duv = zeros(lengthOfSide);
for i = 1 : lengthOfSide
    for j = 1 : lengthOfSide
        Duv(i, j) = norm([i - halfLengthOfSideCeil, j - halfLengthOfSideCeil]);
    end
end

D0 = floor(halfLengthOfSideCeil / 3);
n = 2;
Huv = zeros(lengthOfSide);
for i = 1 : lengthOfSide
    for j = 1 : lengthOfSide
        Huv(i, j) = 1 / (1 + (Duv(i, j) / D0) .^ (2 * n));
    end
end
% figure('Name', 'Butterworth低通滤波器');
% mesh(Huv);
figure('Name', 'Butterworth低通滤波器');
imshow(Huv, []);

%% 处理
Nuv = Huv .* Guv;

figure('Name', '处理后图像傅里叶谱');
imshow(log(abs(Nuv)), []);

%% 变换回空间域
NuvShift = ifftshift(Nuv);                 %对居中的傅里叶变换结果进行还原
fxy = real(ifft2(NuvShift));               %进行傅里叶逆变换

figure('Name', '处理后图像');
imshow(uint8(fxy));

%% 被过滤掉的部分
DFuv = (1 - Huv) .* Guv;

figure('Name', '处理后差图像傅里叶谱');
imshow(log(abs(DFuv)), []);

DFuvShift = ifftshift(DFuv);                 %对居中的傅里叶变换结果进行还原
dfxy = real(ifft2(DFuvShift));               %进行傅里叶逆变换

figure('Name', '处理后差图像');
imshow(uint8(dfxy));


