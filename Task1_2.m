image = imread("mosaic/crayons_mosaic.bmp")
image = rescale(image)
%%
sz = size(image)

%%
r = diag([1 0])
r = repmat(r,sz(1)/2,sz(2)/2)

g = [0 1; 1 0;]
g = repmat(g,sz(1)/2,sz(2)/2)

b = diag([0 1])
b = repmat(b,sz(1)/2,sz(2)/2)

%%
imR = image .* r
imG = image .* g
imB = image .* b

%%
filtRB = [0.25 0.5 0.25;
         0.5 1 0.5;
         0.25 0.5 0.25]
     
filtG = [0 0.25 0;
         0.25 1 0.25;
         0 0.25 0]
%%
imFiltR = imfilter(imR, filtRB)
imFiltG = imfilter(imG, filtG)
imFiltB = imfilter(imB, filtRB)

%%
final = cat(3,imFiltR,imFiltG,imFiltB)

%%
oneMatrix = ones(480,600);
%%
postFiltR = oneMatrix
postFiltR(end,:) = 2
postFiltR(:,end) = 2
postFiltR(end,end) = 4
%%
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
postFiltB = oneMatrix
postFiltB(1,:) = 2
postFiltB(:,1) = 2
postFiltB(1,1) = 4
%%
imFiltPostR = imFiltR .* postFiltR
imFiltPostG = imFiltG .* postFiltG
imFiltPostB = imFiltB .* postFiltB
%%
finalPost = cat(3,imFiltPostR,imFiltPostG,imFiltPostB)
%%
imshow(finalPost)