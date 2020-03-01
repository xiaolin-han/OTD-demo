function [X par]=H(Z_ori,par,sz)
Z_ori_3d = reshape(Z_ori',sz(1),sz(2),size(Z_ori,1));
LR = imfilter(Z_ori_3d,par.psf,'same');
LR = LR(1:par.scale:end,1:par.scale:end,:);
par.LR = LR;
idx = 1;
[h,w,~] = size(par.LR);
for jj = 1:w
    for ii = 1:h
        X(:,idx) = par.LR(ii,jj,:); 
        idx = idx+1;
    end
end
end

