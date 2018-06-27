%实现最佳陷波滤波器
clear;clc;

%% 读取图像
img = imread('data\origin1.png');
if size(img, 3) == 3
    img = rgb2gray(img);
end
figure;
imshow(img);

%% 快速傅里叶变换
IMG = fft2(img);                        %进行傅里叶变换
figure;
imshow(log(abs(IMG) + 1), []);

%% 频域图像居中
IMGCenter = fftshift(IMG);              %对傅里叶变换的结果进行居中处理
figure;
imshow(log(abs(IMGCenter) + 1), []);

IMGCenterOut = log(abs(IMGCenter) + 1);
IMGCenterOut = IMGCenterOut * 255 / max(IMGCenterOut(:));
IMGCenterOut = uint8(IMGCenterOut);
imwrite(IMGCenterOut, 'data\origin1FT.png');

%% Butterworth 低通滤波器
lengthOfSide = 35;
halfLengthOfSide = ceil(lengthOfSide / 2);
Duv = zeros(lengthOfSide);
for i = 1 : lengthOfSide
    for j = 1 : lengthOfSide
        Duv(i, j) = norm([i - halfLengthOfSide, j - halfLengthOfSide]);
    end
end

D0 = floor(halfLengthOfSide / 3);
n = 2;
Huv = zeros(lengthOfSide);
for i = 1 : lengthOfSide
    for j = 1 : lengthOfSide
        Huv(i, j) = 1 / (1 + (Duv(i, j) / D0) .^ (2 * n));
    end
end
figure;
mesh(Huv);
figure;
imshow(Huv, []);

%% 制作低通模版
HNPuv = zeros(size(IMGCenter));




%% 处理


%% 变换回空间域



