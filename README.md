# BTD - burn treatment device software - remote control burn treatment devices
Copyright (C) 2020 Ilya Yukhnovskiy,
e-mail: juhnowski@gmail.com
git repository:  

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License.
This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with
this program. If not, see <https://www.gnu.org/licenses/>.

## Update 

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Running Application Tests

To run all tests for this application, run the following in this directory:

```
pub run test
```

The default configuration file used when testing is `config.src.yaml`. This file should be checked into version control. It also the template for configuration files used in deployment.

## Deploying an Application

See the documentation for [Deployment](https://aqueduct.io/docs/deploy/).

# Development
## Dart
One-time setup:
```
 sudo apt-get update
 sudo apt-get install apt-transport-https
 sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
 sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
```
then
```
 sudo apt-get update
 sudo apt-get install dart
```

## Database
Following instructions for ubuntu:
```
sudo su - postgres
createuser --interactive --pwprompt
createdb -O btdadmin btd
```
where:
- username - btdadmin
- user password - btdadmin
- databasename - btd

## Migration
```
aqueduct db upgrade --connect postgres://btdadmin:btdadmin@localhost:5432/btd
```
after check migrations results:
```
sudo su - postgres
\list
\c btd
\d
select * from device;
```
should print:
```
btd=# select * from _device;
 id |       name       
----+------------------
  1 | mvp1234ZX2020#1
  2 | mvp1234ZX2020#2
  3 | mvp1234ZX2020#3
  4 | mvp1234ZX2020#4
  5 | mvp1234ZX2020#5
  6 | mvp1234ZX2020#6
  7 | mvp1234ZX2020#7
  8 | mvp1234ZX2020#8
  9 | mvp1234ZX2020#9
 10 | mvp1234ZX2020#10
(10 rows)
```