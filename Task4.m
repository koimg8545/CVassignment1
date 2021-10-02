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