function githubSync(dependencies)
% This function takes a cell array of url's to hithub repositories, loop through
% them and ensure they exist on the path, or clone them to your local machine.
%
% Example input:
%
% dependencies={...
% 	'https://github.com/drbenvincent/mcmc-utils-matlab',...
% 	'https://github.com/altmany/export_fig'};
%
% Written by Ben Vincent
% https://github.com/drbenvincent/github-sync-matlab

% input checking
assert(iscellstr(dependencies),'Input to function should be a cell array of url''s to github repositories')
if iscolumn(dependencies), dependencies=dependencies'; end

originalPath = cd;
returnToOrginalDir = onCleanup(@() myCleanupFun(originalPath));

for url=dependencies
	cloneOrUpdateDependency(url{:});
end

end


function cloneOrUpdateDependency(url)
displayDependencyToCommandWindow(url);
repoName = getRepoNameFromUrl(url);
addpath(fullfile(defineInstallPath(),repoName));
if ~isRepoFolderOnPath(repoName)
	cloneGitHubRepo(url, defineInstallPath());
else
	updateGitHubRepo(defineInstallPath(),repoName);
end
end

function displayDependencyToCommandWindow(url)
disp( makeHyperlink(url, makeWeblinkCode(url)) )
end

function repoName = getRepoNameFromUrl(url)
[~,repoName] = fileparts(url);
end

function installPath = defineInstallPath()
% installPath will be the Matlab userpath (eg /Users/Username/Documents/MATLAB)
if isempty(userpath)
	userpath('reset')
end
installPath = userpath;
% Fix the trailing ":" which only sometimes appears
installPath = removeTrailingColon(installPath);
end

function str = removeTrailingColon(str)
if str(end)==':'
	str(end)='';
end
end

function onPath = isRepoFolderOnPath(repoName)
	onPath = exist(repoName,'dir')==7;
end

function cloneGitHubRepo(repoAddress, installPath)
	try
		cd(installPath)
		command = sprintf('git clone %s.git', repoAddress);
		system(command);
	catch
		error('git clone failed')
	end
end

function updateGitHubRepo(installPath,repoName)
try
	cd(fullfile(installPath,repoName))
	system('git pull');
catch
	warning('Unable to update GitHub repository')
end
end

function myCleanupFun(originalPath)
cd(originalPath)
end
