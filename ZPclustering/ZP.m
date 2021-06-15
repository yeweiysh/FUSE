function [A_LS]=ZP(X,k)

neighbor_num = 15;         %% Number of neighbors to consider in local scaling
scale = 0.04;              %% Scale to use for standard spectral clsutering
AUTO_CHOOSE = 1;
CLUSTER_NUM_CHOICES = k;
nGroups = k;

%% centralize and scale the data
X = X - repmat(mean(X),size(X,1),1);
X = X/max(max(abs(X)));

%%%%%%%%%%%%%%%%% Build affinity matrices
D = dist2(X,X);              %% Euclidean distance
A = exp(-D/(scale^2));       %% Standard affinity matrix (single scale)
[D_LS,A_LS,LS] = scale_dist(D,floor(neighbor_num/2)); %% Locally scaled affinity matrix
clear D_LS; clear LS;

% %% Zero out diagonal
% ZERO_DIAG = ~eye(size(X,1));
% A = A.*ZERO_DIAG;
% A_LS = A_LS.*ZERO_DIAG;

% A_LS=A;

%%%%%%%%%%%%%%% ZelnikPerona Rotation clustering with local scaling (RLS)
% if(AUTO_CHOOSE == 0)
%     clusts_RLS = cluster_rotate(A_LS,nGroups);
%     rlsBestGroupIndex = 1;
% else
%     [clusts_RLS, rlsBestGroupIndex, qualityRLS,Vr] = cluster_rotate(A_LS,CLUSTER_NUM_CHOICES,0,1);
% end