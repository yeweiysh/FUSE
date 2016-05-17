function [E,f,whitened,mi]=eigenvectorFuse(A,k,baseconv)

n=size(A,1);
W=normrow(A);
E=zeros(k,n);

for i=1:k
    v0=randn(n,1);
    epsilon=i*ceil(log(k))*baseconv/n;
    [e,~]=pic(W,v0,epsilon,1000);
    E(i,:)=e;
end

[e_hat,~] = whiten(E,k);
whitened=e_hat;

d = k;

num_of_sweeps = d;  %for fixed level the number of sweeps
num_of_levels = 3; %number of levels

ds=[1;1];
mult = 1;
co = IKGV_initialization(mult);
pp=1;
mi=zeros((d^2-d)/2,3);
for i1=1:d-1
    for i2=i1+1:d
        mi(pp,1)=i1;
        mi(pp,2)=i2;
        mi(pp,3)=-IKGV_estimation(e_hat([i1,i2],:),ds,co);
        pp=pp+1;
    end
end
[~,b]=sort(mi(:,3));
mi=mi(b,:);
nangles = 150;
angles = pi/2 * [1:nangles-1]/nangles;

for level = 1 : num_of_levels
    for sweep = 1 : num_of_sweeps
        [e_hat,mi]=fastGS(mi,e_hat,angles,co);
        [~,b]=sort(mi(:,3));
        mi=mi(b,:);
    end
end
f=e_hat';