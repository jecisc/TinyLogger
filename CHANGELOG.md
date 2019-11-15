<!--
git log --pretty="* %s ([%h](https://github.com/jecisc/TinyLogger/commit/%H))" v1.1.4...HEAD --grep="Merge pull" 
('Content' copyWithRegex: 'Merge pull request #[0-9]+ from [^/]+/[0-9]*' matchesReplacedWith: '') copyReplaceAll: '-' with: ' '
-->

# [v1.1.4](https://github.com/jecisc/TinyLogger/compare/v1.1.3...v1.1.4) (2019-11-15)

## Bug fix

* STDOut logger should flush after recoring ([6e6800a](https://github.com/jecisc/TinyLogger/commit/6e6800a5f167e3606d084290c7b3e4cfc2625985))

# [v1.1.3](https://github.com/jecisc/TinyLogger/compare/v1.1.2...v1.1.3) (2019-11-08)

## Infrastructure

*  Improve test coverage using MuTalk (mutation testing) ([716cd41](https://github.com/jecisc/TinyLogger/commit/716cd41655614326b4e20a426bdb58ce5f0f2031))
*  Fix a title in the documentation ([1d6af61](https://github.com/jecisc/TinyLogger/commit/1d6af61b6114533ab20ef3ffaad252f95925d3a8))

# [v1.1.2](https://github.com/jecisc/TinyLogger/compare/v1.1.1...v1.1.2) (2019-09-25)

## Infrastructure

* Update Mocketry dependency to v6.0.x ([c114fea](https://github.com/jecisc/TinyLogger/commit/c114feac2ff65bd11e11fcd7f188e09e90022465))

# [v1.1.1](https://github.com/jecisc/TinyLogger/compare/v1.1.0...v1.1.1) (2019-09-18)

## Bug fixes

* Do not depend on whole Mocketry ([a50d354](https://github.com/jecisc/TinyLogger/commit/a50d3543bf00e76d780d7d3f2fb205280364b637))

## Infrastructure

*   Deprecated method in Pharo 8 ([7f2ab1c](https://github.com/jecisc/TinyLogger/commit/7f2ab1c7a6fc43d23801faed40383e2b6d4279c3))

# [v1.1.0](https://github.com/jecisc/TinyLogger/compare/v1.0.1...v1.1.0) (2019-06-16)

## New Features

* Add way to add a logger only if not already existing ([ed94153](https://github.com/jecisc/TinyLogger/commit/ed94153d9f086fed3a4f801cfe2029db383514c6))
* Add way to initialize remove old log like ensureDelete  ([6529cc8](https://github.com/jecisc/TinyLogger/commit/6529cc8a99360d93ad80a3badff5066021b6053f))

## Infrastructure

* Add pharo 8 to ci ([2b7aded](https://github.com/jecisc/TinyLogger/commit/2b7adede42186b3aca18aea4c910421fc4b13558))

## Documentation

* Documentation v1.1.0 ([e928f63](https://github.com/jecisc/TinyLogger/commit/e928f635134e2081c6a85f24adb7b11bd4261fdf))
* Grammar review ([25b41de](https://github.com/jecisc/TinyLogger/commit/25b41de42009092ef15ba258ba70ea12b8b2384b))
* Grammar review 2 ([10e1a87](https://github.com/jecisc/TinyLogger/commit/10e1a87c45b54f07d9a5dd0205a29277447bbfc8))
* Grammar review 3 ([e279a10](https://github.com/jecisc/TinyLogger/commit/e279a10121503d0cddcb645c765773c14c68c457))

# [v1.0.1](https://github.com/jecisc/TinyLogger/compare/v1.0.0...v1.0.1) (2018-12-08)

## Bug fix

* Fix stdout logging on Pharo 6.1 ([0d8ffdc](https://github.com/jecisc/TinyLogger/commit/0d8ffdc95724b2bf7a4859334469ddc63100f809))
