function x_2d=change3dto2d(x_3d)
idx = 1;
[h,w,~] = size(x_3d);
for jj = 1:w
    for ii = 1:h
        x_2d(:,idx) = x_3d(ii,jj,:); 
        idx = idx+1;
    end
end

