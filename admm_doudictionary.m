
% Spatial Sparse Coefficient Optimization
par.mu         =   0.1;
par.ro         =   1; 
par.Iter       =   1;
ti_pp          =   1;
D         =   D_double(1:(patch_size/ti_pp)^2,:);
S         =   zeros( size(D,2), size(Y_test,2) );
A         =   zeros( size(D,2), size(Y_test,2) );
mu        =   par.mu;
ro        =   par.ro;
Y         =   Y_test;
D0        =   D;
D02       =   D0' * D0;
D0TY      =   D0' * Y;
Ek        =   eye(size(D02,2));
V1        =   zeros( size(S) );
for  i  =  1 : par.Iter
    S       =    inv( D02 + mu * Ek ) * ( D0TY + mu * A- V1/2 );   
    A       =    soft( S + V1/( 2 * mu ), par.lambda / ( 2 * mu ) );
    V1      =    V1 + mu * ( S - A );
    mu      =    mu * ro;
    E_hat_patch_admm     =    1 / beta_d .* D_double( ( patch_size / ti_pp )^2 + 1 : end, : ) * A;
end 

