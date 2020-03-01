function err=Dict_Training_doubleD(k,beta)
load epthon_R
load epthon_M
load epthon_L

a_down_spec = [epthon_M; beta.*epthon_L];
if size(a_down_spec,2)>1000
    m = 1000;
else
    m = size(a_down_spec,2);
end
train_num = size(a_down_spec,2);
p = randperm(size(a_down_spec,2));
p = p(:,1:train_num);
params.data = a_down_spec(:,p); 
params.Tdata = k;
params.dictsize = m;
params.iternum = 30;
params.memusage = 'high';
[D_double,g,err,~] = ksvd_1(params,'');
save('D_double.mat','D_double');
