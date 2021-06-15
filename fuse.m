%Author: Wei Ye (ye@dbs.ifi.lmu.de)
function [meanValue,stdDev]=fuse(A,k,label)
% A: the affinity matrix
% k: the number of clusters
% label: the ground truth
% meanValue: the mean value of AMI
% stdDev: the standard deviation of AMI

unilabel = unique(label);
newlabel = [];
l=1;
for i=1:length(unilabel)
    index = find(label==unilabel(i));
    newlabel(index,1)=l;
    l = l+1;
end

baseconv=1e-5;
p=k+1;

for run=1:50
    [E,pseudoeigen,whitened,mutualInfo]=eigenvectorFuse(A,p,baseconv);
    kur=kurtosis(pseudoeigen);
    [~,b]=sort(kur);
    v=pseudoeigen(:,b(1:k));
    nmi=[];
    ami=[];
    for i=1:100
        C = kmeans(v,k);
        [NMI1,AMI1,~,~]=ANMI_analytical_11(newlabel,C);
        nmi(i)=NMI1;
        ami(i)=AMI1;
    end
    nmi=round(100*nmi)/100;
    ami=round(100*ami)/100;
    uni_nmi=unique(nmi);
    num=[];
    for i=1:size(uni_nmi,2)
        num(i)=length(find(nmi==uni_nmi(i)));
    end
    [~,c]=sort(num);
    ind=find(nmi==uni_nmi(c(end)));
    result_nmi(run)=nmi(ind(1));
    result_ami(run)=ami(ind(1));
end

meanValue=mean(result_ami);
stdDev=std(result_ami);