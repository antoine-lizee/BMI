
neurons=[3     4    18    27    31    36    44    80    81    97
     3     4    18    27    36    44    69    80    81    97
     3     4    27    31    34    35    44    80    81    97
     3     4    27    34    36    44    59    69    75    86
     3     4    69    27    59    36    44    77    75    34
     3     4    69    27    75    36    44    80    34    59
     3     6    31    34    36    44    59    75    90    97
     3    18    27    34    36    44    59    69    75    80
     3    18    27    34    36    44    59    69    75    97
     3    18    27    34    36    44    69    71    75    97
     3    18    27    34    36    44    69    80    75    97
     3    18    27    34    36    44    69    81    75    97
     3    19    27    34    36    44    56    59    69    75
     3    27    34    36    44    56    59    69    75    97
     4     7    18    27    44    55    69    75    86    97]; % from papymamy enhanced !

    
for i=1:size(neurons,1);
    [e(1,i), ~, conf(:,:,1,i)]=CrossValidation(matrix_data_300(:,:,neurons(i,:),:),'mixte',1);
    [e(2,i), ~, conf(:,:,2,i)]=CrossValidation(matrix_data_300(:,:,neurons(i,:),:),'gauss',1);
    [e(3,i), ~, conf(:,:,3,i)]=CrossValidation(matrix_data_300(:,:,neurons(i,:),:),'kgauss',1);
    [e(4,i), ~, conf(:,:,4,i)]=CrossValidation(matrix_data_300(:,:,neurons(i,:),:),'multi',1);
    [e(5,i), ~, conf(:,:,5,i)]=CrossValidation(matrix_data_300(:,:,neurons(i,:),:),'cos',1);
    [e(6,i), ~, conf(:,:,6,i)]=CrossValidation(matrix_data_300(:,:,neurons(i,:),:),'cos135',1);
end

figure(1);
plot(e(1:4,:)');
legend({'multi-fit'; 'gauss'; 'kernel'; 'multivariate'});
