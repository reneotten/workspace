function data = osDepLoad( FilePath , varargin)
%osDepLoad Load function that handles OS specific paths
%   Load function that should work under Win10 and macOS
%   serverPath      File Path on server (ex. 'Common/dir/')
%   fileName        File Name to load
%   varargins:
%   operation       Specifies load operation like 'load' or 'importdata'
%   serverName      Specifies serverName (default: 'Janeway')
%   serverDir       Directory on server (default: 'User Ag Bluhm'), mounted
%                   directory on mac

defaultArgs = struct(...
    'operation',        'load', ...
    'serverName',       'Janeway',...
    'serverDir',        'User AG Bluhm');

args = util.parse_varargin(varargin, defaultArgs);
operation=str2func(args.operation);
serverName=args.serverName;
serverDir=args.serverDir;

if ispc % Win10 at office
    data=operation(['//' serverName '/' serverDir '/' FilePath]);
else % Mac versions
    try
        data=operation(['/Volumes/' serverDir '/' FilePath]);
    catch
        error('osDepLoad:loadError',...
           ['An errror occured! Make sure the server is mounted correctly! \n'...
            'For Mac: \n'...
            '1) Select Finder \n'...
            '2) Cmd + k \n'...
            '3) Mount: "smb://janeway.institut2b.physik.rwth-aachen.de/User Ag Bluhm/"']);
        
    end
    
end

