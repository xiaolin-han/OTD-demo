function [ im_patch , gread_im ] = change_3dtopatches( im_3d, patch_size, lamda )
[r c h]=size(im_3d);
kk = 1;
clear im_patch
gread_im = zeros(r,c);
for i = 1:h
    for j = 1:lamda:r-patch_size+1
        for k = 1:lamda:c-patch_size+1
           patch = im_3d(j:j+patch_size-1,k:k+patch_size-1,i);
           im_patch(:,kk)=patch(:);
           gread_im(j:j+patch_size-1,k:k+patch_size-1) = gread_im(j:j+patch_size-1,k:k+patch_size-1)+1;
           kk = kk+1;
        end
    end
end
gread_im = gread_im./h;
end

