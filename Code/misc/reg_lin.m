
x=1:10000;
x2=(2:2:20000).^2;
yr=1+rand(1,length(x2))+x*2+x2*4;
yg=1+randn(1,length(x2))+x*2+x2*4;

X=[x',x2'];
[b dev]=glmfit(X,yr)
[b dev]=glmfit(X,yg)

X2=[ones(length(x2),1),X];

b=X2\yr'
b=X2\yg'
b=pinv(X2)*yg';
b
b=pinv(X2)*yr';
b