function [seq] = randomseqgen(data,randnum)

n=size(data,1);
colon_sequence=zeros(randnum,n);

for i=1:randnum

 rand_sequence=randperm(n);
 
seq(i,:)= rand_sequence;

end



