function [ Rcorr ] = reflection( w,R_s, Rohmic, Cs, varargin)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
defaultArgs = struct(...
	'C',        0.8*1e-12, ...
    'L',           620*1e-9);
    
args = util.parse_varargin(varargin, defaultArgs);

C=args.C;
L=args.L;
%R_s=50*1e3;
C2=Cs;
Z0=50;

Z_c=1./(1i.*w.*C);
Z_ccorr=1./(1i.*w.*C2);
Z_L=1i.*w.*L;

Zcorr=Z_L+1./(1./Z_c+1./(Rohmic+1./(1./R_s+1./Z_ccorr)));

Rcorr=(Zcorr-Z0)./(Zcorr+Z0);



end

