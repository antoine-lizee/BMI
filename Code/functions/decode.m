function [ angles ] = decode( trials_neur, param )
%DECODE Global decoding function that calls the appropriate "subfunctions"
%   - trials_neur SHOULD be a 3D matrix n_n*n_T*n_t, with the trials in the
%   third dimension.
%   - angles is the given "classes" decoded. It is a vector.
%
%   Copyright A.L. @ Mashed Potatoes @ ICL 02/03/2012

n_n=size(trials_neur,1);
n_t=size(trials_neur,3);
angles=zeros(1,n_t);
meth=param.method;

switch meth
    case{'gauss','gamma','binom','mixte'}
        for i_t=1:n_t
            angles(i_t)=decode_LL(trials_neur(:,:,i_t),param);
        end
    case{'multi'}
        for i_t=1:n_t
            angles(i_t)=decode_multi(trials_neur(:,:,i_t),param);
        end
    case 'cos'
        for i_t=1:n_t
            angles(i_t)=decode_cos(trials_neur(:,:,i_t),param);
        end
    case 'cos135'
        for i_t=1:n_t
            angles(i_t)=decode_cos135(trials_neur(:,:,i_t),param);
        end
    case 'kgauss'
        for i_t=1:n_t
            angles(i_t)=decode_kernel(trials_neur(:,:,i_t),param);
        end
end

end

