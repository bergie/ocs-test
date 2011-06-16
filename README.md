Open Collaboration Services API tests
=====================================

[Open Collaboration Services](http://www.freedesktop.org/wiki/Specifications/open-collaboration-services) (OCS) is a specification for providing social and collaborative features in a reusable and decoupled way. With OCS, users can collaborate with each other across different services and clients. OCS aims to bring features of social web also available for mobile and desktop software.

Each client should be able to talk with multiple OCS services, and each OCS service should be able to support any OCS-compatible client.

The `ocs-test` tool aims to provide a comprehensive set of API tests for verifying correctness of OCS service implementations.

## Installation

Check out this Git repository. To run the tests you also need a recent version of [node.js](http://nodejs.org/) and the following [npm](http://npmjs.org/) packages:

* [coffee-script](http://jashkenas.github.com/coffee-script/)
* [api-easy](https://github.com/ryankirkman/api-easy)
* [xml2js](https://github.com/Leonidas-from-XIV/node-xml2js)
* [vows](http://vowsjs.org/)

## Running the tests

The OCS tests are targeted at a given OCS service implementation by pointing it to a [provider file](http://www.freedesktop.org/wiki/Specifications/open-collaboration-services#Providerfiles). For example:

    $ coffee ocs-test.coffee http://apps-beta.meego.com/ocs/providers.xml

## Improving the tests

Current OCS test coverage is very small. In order to improve the tests, feel free to fork this repository and send pull requests.

Discussion about these tests and OCS in general should happen on the [OCS mailing list](http://lists.freedesktop.org/mailman/listinfo/ocs).
