
clc;
clear all;
warning off;
addpath(genpath(pwd));
load a_ori_select    % referenced image
load L

space_rate = 5;      % downsampling rate
band_max = 93;       % band number
patch_size = 10;     % patch size
lamda = 10;          
beta_d = 0.1;
T3 = 20;
% Spectral dictionary and Sparse Coefficient Optimization
[Y_R, Y_L, X_hat, a_ori_spec, par, sz, delt ] = Optimization_in_spectral_domain(a_ori_select,space_rate,band_max,L);
% Spatial dictionary and Sparse Coefficient Optimization
E_hat = Optimization_in_spatial_domain(Y_R, Y_L, X_hat, a_ori_spec, par, sz, delt, band_max, L, patch_size, lamda, beta_d,T3 );
% reconstruction and quality matric
x_re_douD = reshape(X_hat'+ E_hat',sz(1),sz(2),band_max);
[err_max,err_l1,err_l2,SNR,mean_Q,SAM,RMSE,ERGAS,D_dist] = metrics(a_ori_select(3:end-3,3:end-2,:),x_re_douD(3:end-3,3:end-2,:),6);
ssim  =  cal_ssim(a_ori_select(3:end-2,3:end-2,:),x_re_douD(3:end-2,3:end-2,:),0,0);
fprintf(' MSE: %.4f\n PSNR: %.4f\n UIQI: %.4f\n SAM: %.4f\n ERGAS: %.4f\n SSIM: %.4f\n',...
    RMSE^2,10*log10(255^2/RMSE^2),mean_Q,SAM,ERGAS,ssim);
