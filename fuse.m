%Author: Wei Ye (ye@dbs.ifi.lmu.de)
function [meanValue,stdDev]=fuse(A,k,label)

baseconv=1e-5;
p=k+1;
for run=1:50
    [E,pseudoeigen,whitened,mutualInfo]=eigenvectorFuse(A,p,baseconv);
    kur=kurtosis(pseudoeigen);
    [~,b]=sort(kur);
    v=pseudoeigen(:,b(1:k));
    
    for i=1:100
        C = kmeans(v,k);
        [~,AMI,~,~]=ANMI_analytical_11(label,C);
        tmpami(i)=AMI;
    end
    tmpami=round(100*tmpami)/100;
    unitmp=unique(tmpami);
    for i=1:size(unitmp,2)
        num(i)=size(find(tmpami==unitmp(i)),1);
    end
    [~,c]=sort(num);
    index=find(tmpami==unitmp(c(end)));
    resultami(run,1)=unitmp(c(end));
end

meanValue=mean(resultami);
stdDev=std(resultami);