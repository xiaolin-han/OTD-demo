function [ im_recon_3d ] = chage_patchesto3d( im_patch , patch_size, lamda,gread_im, r,c,h)
kk = 1;
im_hat_3d = zeros(r,c,h);
for i = 1:h
    for j = 1:lamda:r-patch_size+1
        for k = 1:lamda:c-patch_size+1
            patch_2d = reshape(im_patch(:,kk),patch_size,patch_size);
            im_hat_3d(j:j+patch_size-1,k:k+patch_size-1,i) = im_hat_3d(j:j+patch_size-1,k:k+patch_size-1,i)+patch_2d;
            kk = kk+1;
        end
    end
end
for i = 1:h
    im_recon_3d(:,:,i) = im_hat_3d(:,:,i)./gread_im;
end
end

