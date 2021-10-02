image = imread("mosaic/crayons_mosaic.bmp")
image = rescale(image)  % use double type for precise computation

%%
% task 1 start
sz = size(image)

%%
% make 2*2 matrix and repeat it as size of image
r = diag([1 0])
r = repmat(r,sz(1)/2,sz(2)/2)

g = [0 1; 1 0;]
g = repmat(g,sz(1)/2,sz(2)/2)

b = diag([0 1])
b = repmat(b,sz(1)/2,sz(2)/2)

%%
% divide image to R, G, B channel
imR = image .* r
imG = image .* g
imB = image .* b

%%
imshow(imR)

%%
imshow(imG)

%%
imshow(imB)

%%
% task2 start
% average filters
filtRB = [0.25 0.5 0.25;
         0.5 1 0.5;
         0.25 0.5 0.25]
     
filtG = [0 0.25 0;
         0.25 1 0.25;
         0 0.25 0]
     
%%
% apply filters
imFiltR = imfilter(imR, filtRB)
imFiltG = imfilter(imG, filtG)
imFiltB = imfilter(imB, filtRB)

%%
% concatenation
final = cat(3,imFiltR,imFiltG,imFiltB)

%%
% post-processing
oneMatrix = ones(480,600);

%%
% R channel edge filter
postFiltR = oneMatrix
postFiltR(end,:) = 2
postFiltR(:,end) = 2
postFiltR(end,end) = 4

%%
% G channel edge filter
postFiltG = oneMatrix
topEdge = repmat([4/3 1],1, 300)
bottomEdge = repmat([1 4/3],1, 300)
leftEdge = repmat([4/3;1],240, 1)
rightEdge = repmat([1;4/3],240, 1)

postFiltG(1,:) = topEdge
postFiltG(end,:) = bottomEdge
postFiltG(:,1) = leftEdge
postFiltG(:,end) = rightEdge
postFiltG(1,1) = 2
postFiltG(end,end) = 2

%%
% B channel edge filter
postFiltB = oneMatrix
postFiltB(1,:) = 2
postFiltB(:,1) = 2
postFiltB(1,1) = 4

%%
% apply filters
imFiltPostR = imFiltR .* postFiltR
imFiltPostG = imFiltG .* postFiltG
imFiltPostB = imFiltB .* postFiltB

%%
finalPost = cat(3,imFiltPostR,imFiltPostG,imFiltPostB)

%%
imshow(finalPost)
