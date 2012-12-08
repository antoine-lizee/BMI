for i=1:10
    figure(i);
    clf;
    Rasterplot(matrix_data_test,(i-1)*10+1:i*10,1:100)
end

for i=1:10
    figure(i);
    Rasterplot(matrix_data_test , poolNeurons2((i-1)*10+1:i*10), 1:100, 1)
end

Rasterplot(matrix_data_test , 42:47, 1:100, 1)
