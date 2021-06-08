%Author: Wei Ye (ye@dbs.ifi.lmu.de)
function [meanValue,stdDev]=fuse(A,k,label)
% A: the affinity matrix
% k: the number of clusters
% label: the ground truth
% meanValue: the mean value of AMI
% stdDev: the standard deviation of AMI


baseconv=1e-5;
p=k+1;

parfor run=1:50
    [E,pseudoeigen,whitened,mutualInfo]=eigenvectorFuse(A,p,baseconv);
    kur=kurtosis(pseudoeigen);
    [~,b]=sort(kur);
    v=pseudoeigen(:,b(1:k));
    tmpami=[];
    for i=1:100
        C = kmeans(v,k);
        [~,AMI,~,~]=ANMI_analytical_11(label,C);
        tmpami(i)=AMI;
    end
    tmpami=round(100*tmpami)/100;
    unitmp=unique(tmpami);
    num=[];
    for i=1:size(unitmp,2)
        num(i)=length(find(tmpami==unitmp(i)));
    end
    [~,c]=sort(num);
    resultami(run,1)=unitmp(c(end));
end

meanValue=mean(resultami);
stdDev=std(resultami);