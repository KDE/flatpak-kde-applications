# Flatpak Manifests for KDE Apps Nightly builds

This repository is used by KDE's Jenkins instance to create Nightly Flatpak
builds of KDE Apps. Stable Flatpak builds are published on Flathub. See:

* [Tutorials/Flatpak](https://userbase.kde.org/Tutorials/Flatpak)
* [Your app on kdeapps: How and where to publish your manifests](https://develop.kde.org/docs/packaging/flatpak/publishing/).

## Moving manifests to each application repo

As part of a
[Season of KDE 2023 project](https://community.kde.org/SoK/Ideas/2023#Systematization_1:_Automate_Flatpak_checks_in_GitLab_Invent_CI)
following the
[Automate and systematize internal processes Goal](https://community.kde.org/Goals/Automate_and_systematize_internal_processes),
we are moving all manifests for KDE Apps to each project repo to be able to
benefit from checks during Merge Requests via KDE Invent's GitLab CI.

## How to add your application to the Nightly repo

We strongly encourage developers to add their Flatpak manifests in their
application source repository to enable per commit / merge request Flatpak CI
builds on their repository.

You can then add a `.remoteapp` file in this repo to have the Flatpak be built
by KDE binary factory (Jenkins). See existing files in the repo for examples.

## How to add Flatpak CI To Your Repository

1. Add the Flatpak manifest to your source repository as
   `.flatpak-manifest.json` or `.flatpak-manifest.yml`.
2. In your manifest, change source of your application module to use current
   directory. Eg.

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

    For any other KDE dependency, use the development or master branch. For KDE
    Frameworks, use the latest released tag.
3. Add the following to the list of includes in `.gitlab-ci.yml`:

    ```yml
    include:
        ...
        - https://invent.kde.org/sysadmin/ci-utilities/raw/master/gitlab-templates/flatpak.yml
    ```

After this, your repository should have Flatpak CI builds enabled and will run
on every pipeline run. Flatpak CI builds will also generate artifacts.

For now, application maintainers need to ensure all modules in manifests are up
to date. Developers can run the
[flatpak-external-data-checker](https://github.com/flathub/flatpak-external-data-checker)
to manually update external dependencies.

We will add automation in the future to check for updates and open merge
requests.

## Issues

Issues can be reported on the issues tab, or discussed on [#flatpak:kde.org](https://matrix.to/#/#flatpak:kde.org).
