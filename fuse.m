%Author: Wei Ye (ye@dbs.ifi.lmu.de)
function f=fuse(A,k)

baseconv=1e-5;
p=k+1;
[E,eigen,whitened,mi]=eigenvectorFuse(A,p,baseconv);
kur=kurtosis(eigen);
[~,b]=sort(kur);
f=eigen(:,b(1:k));