# checkGitHubDependencies
If your Matlab project uses other GitHub repositories, then you can use this function to make those those dependencies are installed and updated.

## Installation

Clone this repository to somewhere relevant.

```matlab
cd('~/Documents/Matlab')
system('git clone https://github.com/drbenvincent/github-sync-matlab.git')
```

## Example use

Make sure the folder is on the matlab path
```matlab
addpath('~/Documents/Matlab/github-sync-matlab')
```

Use as follows. *Warning this will download or update the repositories to your machine.*
```matlab
dependencies={...
    'https://github.com/drbenvincent/mcmc-utils-matlab',...
    'https://github.com/altmany/export_fig'};
githubSync(dependencies)
```
