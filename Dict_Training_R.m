function [err]=Dict_Training_R(m)
load Y_R  
a_down_spec = Y_R;
k = 20; 
train_num = size(a_down_spec,2);
p = randperm(size(a_down_spec,2));
p = p(:,1:train_num);
params.data = a_down_spec(:,p); 
params.Tdata = k;
params.dictsize = m;
params.iternum = 30;
params.memusage = 'high';
[Dksvd_R,g,err,~] = ksvd_1(params,'');
save('Dksvd_R.mat','Dksvd_R');

