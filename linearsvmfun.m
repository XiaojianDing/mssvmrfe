
epsilon = .000001;

% C=2^(1);
C=a1;


verbose = 0;

 tic
ps = xapp * xapp';
H =ps.*(yapp*yapp'); 
e = ones(size(yapp));

[alpha , lambda , pos] = monqprfe(H,e,yapp,0,C,epsilon,verbose); 
alphaall=zeros(size(e));
alphaall(pos)=alpha;
 
w = (alphaall.*yapp);
y = ps * w +lambda;
 t=toc;
 
 
 tic
ps1 =  xtest * xapp';
y1 = ps1 * w +lambda;
 t1=toc;
 



% %---------------Accuracy of trian data-----------------------%
% 
% 
n=size(xapp,1);
     err=0;
   for i=1:n
    if(yapp(i)==1)
        if(y(i)<0)
            err=err+1;
        end
    else
        if(y(i)>0)
            err=err+1;
        end
    end
   end
   
   accu=(n-err)/n;
   

    
   n1=size(xtest,1);
     err1=0;
   for i=1:n1
    if(ytest(i)==1)
        if(y1(i)<=0)
            err1=err1+1;
        end
    else
        if(y1(i)>=0)
            err1=err1+1;
        end
    end
   end
   
   accu1=(n1-err1)/n1;



