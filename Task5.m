image = imread("data/00125v.jpg")
image = rescale(image)
%%
sz = size(image)
h = fix(sz(1)/3)
w = sz(2)

%%
R = imcrop(image,[0 2*h-1 w h])
G = imcrop(image,[0 h-1 w h])
B = imcrop(image,[0 1 w h])


%%
imshow(R)
%%
imshow(G)
%%
imshow(B)

%%
c = normxcorr2(G,R);
%%
[ypeak,xpeak] = find(c==max(c(:)));
%%
yoffSet = ypeak-h;
xoffSet = xpeak-w;
%%
imR = imtranslate(R, [-xoffSet -yoffSet])

%%
c2 = normxcorr2(G,B);
%%
[ypeak2,xpeak2] = find(c2==max(c2(:)));
%%
yoffSet2 = ypeak2-h;
xoffSet2 = xpeak2-w;
%%
imB = imtranslate(B, [-xoffSet2 -yoffSet2])
%%
imG = G

%%
final = cat(3,imR,imG,imB)
%%
imshow(final)

%%
rowAverageR = mean(histeq(imR), 2) 
rowAverageB = mean(histeq(imB), 2) 
rowAverageG = mean(histeq(imG), 2) 
%%
rowCropR = rowAverageR > 0.18
rowCropG = rowAverageG > 0.18
rowCropB = rowAverageB > 0.18
%%
rowFiltR = repmat(rowCropR,[1 w])
rowFiltG = repmat(rowCropG,[1 w])
rowFiltB = repmat(rowCropB,[1 w])
%%
colAverageR = mean(histeq(imR)) 
colAverageB = mean(histeq(imB))
colAverageG = mean(histeq(imG))
%%
colCropR = colAverageR > 0.18
colCropG = colAverageG > 0.18
colCropB = colAverageB > 0.18
%%
colFiltR = repmat(colCropR,[h+1 1])
colFiltG = repmat(colCropG,[h+1 1])
colFiltB = repmat(colCropB,[h+1 1])
%%
borderFilt = rowFiltR .* rowFiltG .* rowFiltB .* colFiltR .* colFiltG .* colFiltB
rowFilt = rowCropR .* rowCropG .* rowCropB
colFilt = colCropR .* colCropG .* colCropB
%%
y1 = max(find(rowFilt(1:fix(h/2)) == 0))
y2 = fix(h/2) + min(find(rowFilt(fix(h/2)+1:end) == 0))
%%
x1 = max(find(colFilt(1:fix(h/2)) == 0))
x2 = fix(h/2) + min(find(colFilt(fix(h/2)+1:end) == 0))
%%
finalCrop = imcrop(final,[x1 y1 x2-x1 y2-y1])
imshowpair(final,finalCrop,"montage")

%%
imshow(borderFilt)
%%
imshow(imG)
%%
imshow(finalCrop)