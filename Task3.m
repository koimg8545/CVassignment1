load mosaic.mat
%%
originResize = rescale(origin)
originR = originResize(:,:,1)
originG = originResize(:,:,2)
originB = originResize(:,:,3)

%%
interR = finalPost(:,:,1)
interG = finalPost(:,:,2)
interB = finalPost(:,:,3)

%%
subR = (originR - interR).^2
subG = (originG - interG).^2
subB = (originB - interB).^2

%%
subMat = subR+subG+subB
%%
imshow(subMat)
%%
sumR = sum(sum(subR))
sumG = sum(sum(subG))
sumB = sum(sum(subB))
%%
maxValue = max(max(subMat))
meanValue = mean(mean(subMat))
%%
s = double(originR) - interR

%%
showimage = subMat
%%
imagesc(subMat,[0 0.1])
colorbar
