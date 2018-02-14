# hubo

hubo == "git(hub) (o)pen"

This is just another command line utility for GitHub that allows you to:
- Quickly open your repository.
- Open files / directory paths on your current branch / commit.
- Open your pull requests page.
- Open your issues page.

# Examples

```sh
$ hubo
# opens https://github.com/REMOTE_USER/REPO/tree/BRANCH

$ hubo [path] [line number]
# Example:
# $ hubo src/myfile.js 34
# opens https://github.com/REMOTE_USER/REPO/blob/BRANCH/src/myfile.js#L34

$ hubo pr
# opens https://github.com/REMOTE_USER/REPO/pulls

$ hubo issues
# opens https://github.com/REMOTE_USER/REPO/issues
```

# TODO
- Add the ability to open your repository on any branch without having to check it out first.
