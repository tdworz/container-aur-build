# Container: AUR Build

An OCI (Docker) container to build Arch Linux packages, particularly packages in the Arch User Repository (AUR).

Some use cases for this container are:

- Build packages without cruft left over by build requirements
- Build packages without needing to run Arch Linux on your host system
- Experiment with package builds without fear of unexpected system changes

## Usage

### Build AUR Packages

To build packages from the [AUR](https://aur.archlinux.org), run the following command substituting `<package>` for a single package you want to build.

```sh
docker run --rm --pull always -v $(pwd):/out tdworz/aur-build <package>
```

Using the preceding command will cause built packages to be placed in the current directory. If you prefer built packages to be placed elsewhere, adjust the volume mount, `-v /path/to/output:/out`.

### Build Custom Packages

To build packages not in AUR, the default container behavior can be overridden.

The following example will build a package from sources in `<source_directory>` and will place the built package in `<output_directory>`.

```sh
docker run --rm --pull always -v <source_directory>:/build/src -v <output_directory>:/out --entrypoint /bin/bash tdworz/aur-build -c 'pacman -Syu --noconfirm && cd /build/src && sudo -u builder makepkg --noconfirm -sf'
```

Keep in mind, when not using absolute paths, you must prefix relative paths appropriately. For example, if you have a custom package inside a directory `my-custom-package/` within the current directory, the correct way to mount the directory is `-v ./my-custom-package:/build/src`. The same principle applies to the output directory.

## Container Repositories

Built images may be found in the following container registries:

- Docker Hub: https://hub.docker.com/r/tdworz/aur-build

## Copyright & License

Copyright ©2023 Tom Dworzanski (tdworz)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, please see https://www.gnu.org/licenses/gpl-3.0.en.html.
