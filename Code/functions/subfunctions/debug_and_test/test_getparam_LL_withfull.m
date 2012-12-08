function [ h ] = test_getparam_LL_withfull( act_neur, method, fig )
%TEST_GETPARAM_LL Summary of this function goes here
%   Detailed explanation goes here

if nargin<3
    fig=1;
end

if strcmp(method,'binomgauss')
    [ param ] = getparam( act_neur, 'gauss' );
    [ param1 ] = getparam( act_neur, 'binom' );
else
    [ param ] = getparam( act_neur, method );
end

n_t=size(act_neur,1);
n_a=size(act_neur,2);
n_n=size(act_neur,3);
n_T=size(act_neur,4);

sum_act=sum(act_neur,4);

figure(fig);
clf;

for i_a=1:n_a
    for i_n=1:n_n
        test=sum_act(:,i_a,i_n);
        [n_r, r]=hist(test,min(test):1:max(test));
        figure(fig*10+i_n); % MULTI WINDOWS version
        subplot(2,4,i_a);
        % subplot(n_n,n_a,(i_n-1)*n_a+i_a); % ONE WINDOW version
        %DEBUG: title(['i_n ' num2str(i_n) ',i_a ' num2str(i_a) ]); 
        hold on
        bar(r,n_r);
        switch method
            case 'gauss'
                plot(r,100*normpdf(r,param.coeff(i_n,i_a,1),param.coeff(i_n,i_a,2)),'o-r');
                bins=min(test):max(test);
                [~, p]=chi2gof(test,'ctr',bins);
                title(['p=' num2str(p)]);
            case 'gamma'
                plot(r,100*gampdf(r,param.coeff(i_n,i_a,1),param.coeff(i_n,i_a,2)),'o-r');
            case 'binom'
                plot(r,100*binopdf(r,param.coeff(i_n,i_a,1),param.coeff(i_n,i_a,2)),'o-r');
                title(['mu=' num2str(mean(test))]);
            case 'binomgauss'
                plot(r,100*normpdf(r,param.coeff(i_n,i_a,1),param.coeff(i_n,i_a,2)),'o-r');
                bins=min(test):max(test);
                [~, p]=chi2gof(test,'ctr',bins);
                title(['p=' num2str(p) ' / mu=' num2str(mean(test))]);
                plot(r,100*binopdf(r,param1.coeff(i_n,i_a,1),param1.coeff(i_n,i_a,2)),'o-g');
                
        end
    end
end   


end

