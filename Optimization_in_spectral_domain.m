function [Y_R, Y_L, X_hat, a_ori_spec, par, sz, delt ] = Optimization_in_spectral_domain(a_ori_select,space_rate,band_max,L)
a_ori_spec = change3dto2d(a_ori_select);
% blurring and downsampling in spatial domain
psf_space = fspecial('gauss',5,3);
X_blur_1 = imfilter(a_ori_select,psf_space,'same'); 
X_BS = X_blur_1(1:space_rate:end,1:space_rate:end,:);  
Y_R = change3dto2d(X_BS);
save('Y_R.mat','Y_R')
Y_L = L * a_ori_spec;
% Spectral dictionary and Sparse Coefficient Optimization 
Dict_Training_R(100);
load Dksvd_R
ADMM_D_0;
ADMM_D;

end

