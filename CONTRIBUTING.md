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

Changes that don't affect gameplay such as documentation can be
done and submitted more simply by using the [web-based editor].

[fork this repository]: https://docs.github.com/en/get-started/quickstart/fork-a-repo
[Directory Junction]: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/mklink
[Eden Editor]: https://community.bistudio.com/wiki/Eden_Editor:_Introduction
[Link Shell Extension]: https://schinagl.priv.at/nt/hardlinkshellext/linkshellextension.html
[GitHub Flow]: https://docs.github.com/en/get-started/quickstart/github-flow
[web-based editor]: https://docs.github.com/en/codespaces/the-githubdev-web-based-editor

## Resources

- Community Wiki: https://community.bistudio.com/wiki/Main_Page
- SQF Best Practices: https://community.bistudio.com/wiki/Code_Best_Practices

## SQF/CPP Style Guide

- All indentation should use 4 spaces
- Lines should not contain any trailing whitespace except a newline
- All files should end with a single trailing newline
- Lines should avoid exceeding 80 characters unless its readability would
  be worsened by line breaks
- SQF functions should be documented
- Strings should use double quotes
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

- Declaring functions in [`CfgFunctions`] should be preferred over compiling
  or running script files directly, e.g. `compileScript` / `execVM`
- To help with localization, [stringtable.xml] declarations should be used
  for any strings that are seen by users

[`CfgFunctions`]: https://community.bistudio.com/wiki/Arma_3:_Functions_Library
[stringtable.xml]: https://community.bistudio.com/wiki/Stringtable.xml
