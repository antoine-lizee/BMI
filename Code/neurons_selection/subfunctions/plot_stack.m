function [ h ] = plot_stack( stack_hist, fig)
%MOVIE_STACK Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    fig=200;
end

n_nt=20;
n_age=size(stack_hist,1);

stack_image=zeros(n_age, n_nt);
for i=1:n_age
    stack_image(i,stack_hist(i,:))=1;
end

figure(fig);
clf
h=imagesc(stack_image');


end

