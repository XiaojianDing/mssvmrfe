
load colondata.mat


xapp=colondata(:,1:(size(colondata,2)-1));
yapp=colondata(:,(size(colondata,2)));


%------------------parameter C------------------------

% C=2^(1);
C=a1;

epsilon = .000001;
verbose = 0;
numEliminate=1;



allFeatIndex = 1:size(xapp,2); 
rankedFeat = []; 

tic
while length(rankedFeat) < size(xapp,2)
 feat_tmp = allFeatIndex(); 
 feat_tmp(rankedFeat) = [];
 feat_tmp_index = allFeatIndex(setdiff(allFeatIndex, rankedFeat )); 
 
 xapp1=xapp(:,feat_tmp);
 
ps = xapp1 * xapp1';
H =ps.*(yapp*yapp'); 
e = ones(size(yapp));

[alpha , lambda , pos] = monqprfe(H,e,yapp,0,C,epsilon,verbose); 
alphaall=zeros(size(e));
alphaall(pos)=alpha;
 

 
w = alpha' * xapp1(pos,:);

 
 [val ind] = sort(abs(w)); % sort  in ascending order.
  % ind = find(w == min(abs(w)));
   featureIndex = feat_tmp_index(ind(1:min(numEliminate, length(ind)))); 
 rankedFeat = [featureIndex rankedFeat]; 
end
t=toc




