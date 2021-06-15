%Author: Wei Ye (ye@dbs.ifi.lmu.de)
function [meanValue,stdDev]=fuse(A,k,label)
% A: the affinity matrix
% k: the number of clusters
% label: the ground truth
% meanValue: the mean value of AMI
% stdDev: the standard deviation of AMI

baseconv=1e-5;
p=k+1;

for run=1:50
    tic;[E,f,whitened,mi]=eigenvectorFuse(A,p,baseconv);
    time(run,1)=toc;
        
    kk=kurtosis(f);
    [~,b]=sort(kk);
    ff=f(:,b(1:k));
    for i=1:100
        C = kmeans(ff,k);
        [NMI,AMI,AVI,~]=ANMI_analytical_11(label,C);
        v(i) = NMI;
        v1(i)=AMI;
        v2(i)=AVI;
    end
    v=round(100*v)/100;
    v1=round(100*v1)/100;
    v2=round(100*v2)/100;
    univ=unique(v);
    for i=1:size(univ,2)
        num(i)=size(find(v==univ(i)),1);
    end
    [~,c]=sort(num);
    inde=find(v==univ(c(end)));
    fuse_result(run,1)=univ(c(end));%NMI
    fuse_result(run,2)=v1(inde(1));%AMI
    fuse_result(run,3)=v2(inde(1));%AVI
    clear ff;
    clear c;
    clear num;

end

meanValue=mean(fuse_result(:,2));
stdDev=mean(fuse_result(:,2));