
% Spectral dictionary Optimization 
D = Dksvd_R;  
par.psf = fspecial('gauss',5,3);
par.scale = space_rate;
sz     = [size(a_ori_select,1) size(a_ori_select,2)];
[X par]= H_L(a_ori_spec,par,sz);
par.B  = Set_blur_matrix(par); 
par.KK = (par.B)';
Y_R    = a_ori_spec * par.KK;
par.K  = size(D,2);
par.h  = sz(1);
par.w  = sz(2);
par.eta1       =    0.1; 0.001; 
par.mu         =   0.001;
par.ro         =   0.1; 
par.Iter       =  1; %10;
eta2      =   par.eta1;
mu_2      =   par.mu;
ro        =   par.ro;
A_hat     =   A * par.KK;
Z         =   zeros( size(D * A) );
V1_2      =   zeros( size(Z) );
D0        =   L * D;

for  i  =  1 : par.Iter
   Z        =  inv(L'*L + mu_2 * eye(size(L',1))) * ( L' * Y_L + mu_2 * (D*A +V1_2/(2*mu_2)) );
   D        =  (eta2 * Y_R * A_hat' + mu_2*(Z - V1_2/(2*mu_2)) * A' ) * inv(eta2 * A_hat * A_hat' + mu_2 * A *A');   
   V1_2     =  V1_2 + mu_2*( D*A-Z );    
   mu_2     =  mu_2*ro;
end 
X_hat = D*A;
X_BS_hat = reshape((X_hat*par.KK)',sz(1)/par.scale,sz(2)./par.scale,size(X_hat,1));
delt = reshape(Y_R',sz(1)/par.scale,sz(2)./par.scale,size(Y_R,1))-X_BS_hat;
X_delt = imresize(delt,par.scale,'bicubic');

