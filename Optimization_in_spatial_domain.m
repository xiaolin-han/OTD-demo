function [ E_hat ] = Optimization_in_spatial_domain(Y_R, Y_L, X_hat, a_ori_spec, par, sz, delt, band_max, L,patch_size, lamda, beta_d,T3  )
deltp = Y_R - X_hat * par.KK;
X_delt = imresize(delt,par.scale,'bicubic');
X_delt_2d = change3dto2d(X_delt);
E_M = X_delt_2d;
E_M_3d = reshape(E_M',sz(1),sz(2),band_max);
E_L = Y_L - L * X_hat;
E_L_3d = reshape(E_L',sz(1),sz(2),size(L,1));
LE_M = L * X_delt_2d;
LE_M_3d = reshape(LE_M',sz(1),sz(2),size(L,1));
E_ori = a_ori_spec - X_hat;
E_ori_3d = reshape(E_ori',sz(1),sz(2),band_max);
% in the image patch domain
deltp = Y_R - X_hat * par.KK;
E_R_3d = reshape(deltp',sz(1)/5,sz(2)/5,band_max);
LE_R_3d = L * deltp;
[ epthon_R ] = change_3dtopatches( LE_R_3d, patch_size/5, lamda/5 ); 
save('epthon_R.mat','epthon_R')
[ epthon_M ] = change_3dtopatches( LE_M_3d, patch_size, lamda );
[ epthon_L ] = change_3dtopatches( E_L_3d, patch_size, lamda );
save('epthon_M.mat','epthon_M')
save('epthon_L.mat','epthon_L')
% Optimization
Dict_Training_doubleD(T3,beta_d);
load D_double
[ epthon_test , gread_test ] = change_3dtopatches( E_M_3d, patch_size, lamda );
[ epthon_E_ori ] = change_3dtopatches( E_ori_3d, patch_size, lamda );
Y_test = epthon_test;
admm_doudictionary;
[ E_hat_3d ] = chage_patchesto3d( E_hat_patch_admm , patch_size, lamda,gread_test, sz(1),sz(2),band_max);
E_hat = change3dto2d(E_hat_3d);
end

