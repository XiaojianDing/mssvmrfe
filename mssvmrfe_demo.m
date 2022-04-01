
load colondata.mat

numrand=20;
fsnum=[10,20,30,40,50,60,70,80,90,100];
% fsnum=[1:100];

[seq] = randomseqgen(colondata,numrand); 
sumaveaccu=zeros(numrand,size(fsnum,2));
sumaccu=zeros(25,length(fsnum));

 for aa1=1:25
   a1=2^(aa1-10);
   
linearsvmrfe_colon;


t3=clock;
for kk=1:numrand

rand_sequence=seq(kk,:);
temp_dataset=colondata;
colondata=temp_dataset(rand_sequence, :);

Xtrain=colondata(1:30,1:(size(colondata,2)-1));
Ytrain=colondata(1:30,(size(colondata,2)));

Xtest=colondata(31:62,1:(size(colondata,2)-1));
Ytest=colondata(31:62,(size(colondata,2)));


for num=1:length(fsnum)

xapp=Xtrain(:,rankedFeat(1:fsnum(num)));
xtest=Xtest(:,rankedFeat(1:fsnum(num)));
yapp=Ytrain;
ytest=Ytest;

linearsvmfun;
 
sumaveaccu(kk,num)=accu1;
  
    end
  
  end
  
   
t4=clock;
 totaltime=etime(t4,t3); 
  
  sumaveaccu= sumaveaccu.*100;
  meanaccu=mean(sumaveaccu,1);
  varx=std(sumaveaccu,0,1);
  
  sumaccu(aa1,:)=meanaccu;
  
end



sumaccu_data=sumaccu';

 % normalize each row to unit
   temp_rank= sumaccu_data./repmat(sqrt(sum(sumaccu_data.^2,2)),1,size(sumaccu_data,2));

  % standard deviation of variable 
 sigma=std(temp_rank,0,1);

 % mean 
 meanpre=mean(sumaccu_data,1);

 rank=sigma./meanpre;
  
 ind = find (rank == min(rank));
 %[val ind] = sort(rank)
 
 bestpara=2^(ind-10);
 

