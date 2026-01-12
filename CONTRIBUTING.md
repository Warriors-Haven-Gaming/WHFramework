# Contributing Guide

## Table of Contents

- [Contributing Guide](#contributing-guide)
  - [Table of Contents](#table-of-contents)
  - [Recommended Setup](#recommended-setup)
  - [Resources](#resources)
  - [SQF/CPP Style Guide](#sqfcpp-style-guide)
  - [SQF Best Practices](#sqf-best-practices)

## Recommended Setup

Mission contributors are recommended to [fork this repository], clone it locally,
then create a [Directory Junction] inside your `<Arma 3 profile>/mpmissions/` folder
pointing to `WHFramework.Altis/` so your script edits can be previewed
from the [Eden Editor] in real-time (see also [Link Shell Extension]).
Once set up, you can follow the [GitHub Flow] to make new branches for each
feature, commit your changes, and start pull requests on this repository
to be reviewed and merged.

If you also plan to maintain the map branches, especially merging changes from main
into each branch, consider running [`git config merge.directoryRenames true`]
beforehand to reduce merge conflicts.

Changes that don't affect gameplay such as documentation can be
done and submitted more simply by using the [web-based editor].

[fork this repository]: https://docs.github.com/en/get-started/quickstart/fork-a-repo
[Directory Junction]: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/mklink
[Eden Editor]: https://community.bistudio.com/wiki/Eden_Editor:_Introduction
[Link Shell Extension]: https://schinagl.priv.at/nt/hardlinkshellext/linkshellextension.html
[GitHub Flow]: https://docs.github.com/en/get-started/quickstart/github-flow
[`git config merge.directoryRenames true`]: https://git-scm.com/docs/git-merge.html#Documentation/git-merge.txt-mergedirectoryRenames
[web-based editor]: https://docs.github.com/en/codespaces/the-githubdev-web-based-editor

## Resources

- Community Wiki: https://community.bistudio.com/wiki/Main_Page
- SQF Best Practices: https://community.bistudio.com/wiki/Code_Best_Practices

## SQF/CPP Style Guide

- All indentation should use 4 spaces
- Lines should not contain any trailing whitespace except a newline
- All files should end with a single trailing newline
- Lines should avoid exceeding 100 characters unless its readability would
  be worsened by line breaks
- SQF functions should be documented
- Strings should use double quotes
- Local variables should only be made private with `private _var = ...`
  or `privateAll`, not with the array syntax, `private ["_var", ...]`
- Class names should always be written in `PascalCase`
- Function names should always be written in `camelCase`
- Variable names can use a mix of `snake_case` and `camelCase` as appropriate:

  ```sqf
  // Good:
  WHF_findAPSLoop_script = 0 spawn WHF_fnc_findAPSLoop;
  WHF_earplugs_music_last = 1;
  WHF_earplugs_radio_last = 1;
  private _uid = "";
  private _isPiloted = false;
  private _atMines = ["ATMine"];
  private _initialUnitCount = 0;
  private _getNextPos = {...};
  ```

- Open curly braces should be on the same line as the defining construct:

  ```cpp
  // Good:
  class CfgFunctions {
      class WHF {
          class Helpers {
              ...
          };
      };
  };
  ```

- Statements used to return values in SQF Code types or the last statement
  in a one-line Code type should not have a trailing semi-colon:

  ```sqf
  private _myCode = {
      params ["_x", "_y", "_z"];
      // Good:
      _x + _y > _z
  };

  // Good: no semi-colon in front of closing curly brace
  if (some_condition) then {doThis; doThat};

  private _myCode = {
      // Good: lines that don't have a useful return type can end with a semi-colon
      [1, 2] call WHF_fnc_returnTypeIsNotImportant;
  };
  ```

## SQF Best Practices

- Declaring functions in [`CfgFunctions`] should always be preferred over
  compiling or running script files directly, e.g. `compileScript` / `execVM`.
- To help with localization, [stringtable.xml] declarations should be used
  for any strings that are seen by users.
- Local variables should always be marked with the `private` keyword,
  unless it is intentionally using/overwriting variables from an outer scope.
- When possible, use [guard statements] to simplify conditional expressions
  and reduce indentation.
- When possible, refactor code into loops and functions to reduce code duplication.
- When writing loops in scheduled environment, consider using `sleep` to avoid
  unnecessary hot loops, such as when continuously checking objective conditions
  or the presence of players in an area.
- If there is a non-obvious reason to write something, add a comment explaining
  *why* the code is written as such. Avoid adding comments explaining *what* the
  code does, especially if it can be understood from reading a few lines.
- Commands should be executed in the correct locality to avoid unnecessary
  network traffic. For example, a globally executed function shouldn't call
  a global effect command like `createVehicle` unless the function ensures that
  only one machine runs it, for example, by using an `isServer` condition.
- Variables should not be broadcasted over network if it can be easily computed
  on all clients, such as composition data.
- Avoid performing critical actions on clients such as broadcasting temporary variables,
  since clients can disconnect mid-execution and fail to cleanup after themselves.
  If possible, rely on the server for cleanup, or keep variables local to each client.

[`CfgFunctions`]: https://community.bistudio.com/wiki/Arma_3:_Functions_Library
[stringtable.xml]: https://community.bistudio.com/wiki/Stringtable.xml
[guard statements]: https://en.wikipedia.org/wiki/Guard_(computer_science)
