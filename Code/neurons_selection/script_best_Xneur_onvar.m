load('perf_onvar');
n_neur=6;
neur=zeros(8,n_neur);
for i=1:8
    eval(['neur(i,:)=p_angle_' num2str(i) '(1,1:n_neur);']);
end

neurselec=unique(neur);