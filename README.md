# Flatpak Manifests

This repository houses manifests for KDE Flatpak packages.

Developers are now encouraged to move manifests into application source repository to enable per commit / merge request Flatpak CI builds on their repository.

## Adding Flatpak CI To Your Repository

1. Add the Flatpak manifest to your source repository as `.flatpak-manifest.json` or `.flatpak-manifest.yml`.
2. In your manifest, change source of your application module to use current directory. Eg.

    ```json
    {
        "name": "neochat",
        "buildsystem": "cmake-ninja",
        "sources": [
            {
                "type": "dir",
                "path": "."
            }
        ]
    }
    ```

    For any other KDE dependency, use the development or master branch.
3. Add the following to the list of includes in `.gitlab-ci.yml`:

    ```yml
include:
    ...
    - https://invent.kde.org/sysadmin/ci-utilities/raw/master/gitlab-templates/flatpak.yml
    ```

After this, your repository should have Flatpak CI builds enabled and will run on every pipeline run. Flatpak CI builds will also generate artifacts.

For now, application maintainers need to ensure all modules in manifests are up to date. An easy way to do this is to use git sources for modules. However, it might be required to pin a module to stable version, in which case the application maintainer should update manifest as and when required.

Plans are underway to automate manifests updates.

## Issues

Issues can be reported on the issues tab, or discussed on [#flatpak:kde.org](https://matrix.to/#/#flatpak:kde.org).