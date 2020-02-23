// BTD - burn treatment device software - remote control burn treatment devices
// Copyright (C) 2020 Ilya Yukhnovskiy,
// e-mail: juhnowski@gmail.com
// source code: https://github.com/juhnowski/btd
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License.
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with
// this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:aqueduct/managed_auth.dart';
import 'package:btd/model/user.dart';
import 'btd.dart';
import 'controller/devices_controller.dart';
import 'package:btd/controller/register_controller.dart';

class BtdChannel extends ApplicationChannel {
  ManagedContext context;

  AuthServer authServer;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = BtdConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();

    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route('auth/token')
      .link(() => AuthController(authServer));

    router
      .route('/devices/[:id]')
      .link(() => Authorizer.bearer(authServer))
      .link(() => DevicesController(context));

    router
      .route("/example")
      .linkFunction((request) async {
        return Response.ok({"key": "value"});
      });

    router
      .route('/register')
      .link(() => Authorizer.bearer(authServer))
      .link(() => RegisterController(context, authServer));

    return router;
  }
}

class BtdConfig extends Configuration {
  BtdConfig(String path): super.fromFile(File(path));
  DatabaseConfiguration database;
}