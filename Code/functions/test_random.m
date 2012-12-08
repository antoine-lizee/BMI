for i=1:20;
   param(i)=getparam(matrix_data_300((1+(i-1)*5):5*i,:,:,:),'mixte');
end

for j=1:8
clear test;
for i=1:20;
   test(i)=mean(param(i).coeff(1:10,j,2),1);
end
figure(j)
clf
plot(test);
end

%Nothing works really !