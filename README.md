# GitHub repository synchronization for Matlab
If your Matlab project uses other GitHub repositories, then you can use this function to ensure those those dependencies are installed (cloned) and updated.

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
dependencies={
    'https://github.com/drbenvincent/mcmc-utils-matlab',
    'https://github.com/altmany/export_fig'};
githubSync(dependencies)
```
## Optional input arguments
### Selective updating
Optionally provide a vector (same length as `dependencies`) indicating which dependencies to exclude from updates. The vector can be logical (`true` or `false`) or binary (`0` or `1`).
```matlab
githubSync(dependencies, 'exclude', [false true])
```

### Update the updater
Get any updates to this updating code ;) Uses recursive black magic.
```matlab
githubSync(dependencies, 'selfUpdate', true)
```
