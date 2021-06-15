t = 1;
n = size(W,1);
for i = 1:n
    tmp = find(W(i,:) ~= 0);
    for j = 1:size(tmp,2)
            EdgeWeight(t,1) = i-1;
            EdgeWeight(t,2) = tmp(j)-1;
            EdgeWeight(t,3) = W(i,tmp(j));
            t = t + 1;
    end
end

filename=['C:\Users\ye\Desktop\twomoon\transition.txt'];
fileID = fopen(filename,'w');
fprintf(fileID, '%d %d %f\n', EdgeWeight');
fclose(fileID);

filename=['C:\Users\ye\Desktop\Label.txt'];
fileID = fopen(filename,'w');
fprintf(fileID, '%d\n', y');
fclose(fileID);