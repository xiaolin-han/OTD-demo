
% Spectral Sparse Coefficient Optimization 
D=Dksvd_R;
par.psf=fspecial('gauss',5,3);
par.scale=space_rate;
sz=[size(a_ori_select,1) size(a_ori_select,2)];
[X par]= H_L(a_ori_spec,par,sz);
par.B=Set_blur_matrix(par); 
par.KK=(par.B)';
Y_R=a_ori_spec*par.KK;
par.K=size(D,2);
par.h=sz(1);
par.w=sz(2);
par.lambda     =    0.000001;
par.eta1       =    0.1;
par.mu         =   0.001;
par.ro         =   0.01; 
par.Iter       =   1; %10;
S         =   zeros( par.K, par.h*par.w );
A         =   zeros( par.K, par.h*par.w );
Z         =   zeros( size(X,1), par.h*par.w );
eta1      =   par.eta1;
mu_1        =   par.mu;
Y=Y_L;
D0=L*D;
YRHT       =   Y_R*par.KK';
D02       =   D0'*D0;
D2        =   D'*D;
D0TY      =   D0'*Y;
DTU       =   zeros(par.K, par.h*par.w);
Ek        =   eye(par.K);
V1        =   zeros( size(Z) );
V2        =   zeros( size(S) );
fun       =   zeros(par.Iter, 1);

for  i  =  1 : par.Iter
    S     =    inv( D02 + mu_1*D2 + mu_1*Ek ) * ( D0TY + D'*(mu_1*Z-V1/2) + (mu_1*A-V2/2) );
    DS    =    D*S;
    B_1   =    eta1*YRHT + mu_1*(DS + V1/(2*mu_1));
    B_2   =    inv(eye(size(par.KK',1))-eta1/mu_1.* par.KK'*par.KK);
    Z     =    1/mu_1.* B_1 +  eta1/mu_1^2.* B_1 * par.KK * B_2 * par.KK';
    A     =    soft(S+V2/(2*mu_1), par.lambda /(2*mu_1));
    V2    =    V2 + mu_1*( S - A );
    V1    =    V1 + mu_1*( DS-Z );
end 