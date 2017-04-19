function [ S ] = sensitivity( w,C,L,Rs,varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
defaultArgs = struct(...
	'Cstray',        1e-10, ...
    'Rohmic',        0);
    
args = util.parse_varargin(varargin, defaultArgs);

Rohmic=args.Rohmic;
Cstray=args.Cstray;

% build in calc Vs
% very simple derivative
S = abs(reflection(w,Rs+1.,Rohmic,Cstray,'L',L,'C',C)-reflection(w,Rs-1.,Rohmic,Cstray,'L',L,'C',C))./2.;


end

