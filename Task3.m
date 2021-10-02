load mosaic.mat

%%
% rescale original image
originResize = rescale(origin)
originR = originResize(:,:,1)
originG = originResize(:,:,2)
originB = originResize(:,:,3)

%%
% divide demosaiced image to RGB
interR = finalPost(:,:,1)
interG = finalPost(:,:,2)
interB = finalPost(:,:,3)

%%
% compute squared error
subR = (originR - interR).^2
subG = (originG - interG).^2
subB = (originB - interB).^2

%%
% make squared error matrix
subMat = subR+subG+subB

%%
% compute error in each channel
sumR = sum(sum(subR))
sumG = sum(sum(subG))
sumB = sum(sum(subB))

%%
% get max and mean value
maxValue = max(max(subMat))
meanValue = mean(mean(subMat))

%%
imagesc(subMat,[0 0.1])
colorbar
