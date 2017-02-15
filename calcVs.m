function [ Vs ] = calcVs(Vd, w,R_s, Rohmic, Cstray, varargin)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
defaultArgs = struct(...
	'C',        0.9*1e-12, ...
    'L',           820*1e-9);
    
args = util.parse_varargin(varargin, defaultArgs);

C=args.C;
L=args.L;
Z0=50;

Z_c=1./(1i.*w.*C);
Zstray=1./(1i.*w.*Cstray);
Z_L=1i.*w.*L;

Zcorr=Z0+Z_L+1./(1./Z_c+1./(Rohmic+1./(1./R_s+1./Zstray)));

Vs=Vd.*...
    (1./(1./Zc+1./(Rohmic+1./(1./Rs+1./Zstray)))./Zcorr)*...
    1./(1./Rs+1./Zstray)./(Rohmic+1./(1./Rs+1./Zstray));


end

