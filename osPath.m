function path = osPath( filePath ,varargin)

defaultArgs = struct(...
    'serverName',       'Janeway',...
    'serverDir',        'User Ag Bluhm');

args = util.parse_varargin(varargin, defaultArgs);
serverName=args.serverName;
serverDir=args.serverDir;

if ispc
    path=fullfile('//' ,serverName , serverDir , filePath);
else % Mac versions
    path=fullfile('/Volumes/', serverDir , filePath);
    
end

