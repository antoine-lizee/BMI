function [ h ] = movie_stack( stack_hist, fig, fps)
%MOVIE_STACK Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    fig=100;
end

if nargin < 3
    fps=30;
end

n_nt=20;
n_age=size(stack_hist,1);
n_temp=50;

stack_image=zeros(n_temp, n_nt);
stack_image(stack_hist(1:n_temp,:))=1;

figure(fig);
clf
image(stack_image');

for i_t=1:n_age-n_temp
    stack_image_i=zeros(1,n_nt);
    stack_image_i(stack_hist(i_t,:))=1;
    stack_image=[stack_image(2:end,:); stack_image_i];
    imagesc(stack_image');
    title(['age = ' num2str(i_t)]);
    pause(1/fps);
end
    

end

