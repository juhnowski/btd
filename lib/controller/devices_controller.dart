// BTD - burn treatment device software - remote control burn treatment devices
// Copyright (C) 2020 Ilya Yukhnovskiy,
// e-mail: juhnowski@gmail.com
// source code: https://github.com/juhnowski/btd

// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License.
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with
// this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:aqueduct/aqueduct.dart';
import 'package:btd/btd.dart';
import 'package:btd/model/Device.dart';

class DevicesController extends ResourceController {

  DevicesController(this.context);

  final ManagedContext context;

  final _devices = [
    {'id': 11, 'name':'qwe123sdsw121'},
    {'id': 12, 'name':'qwe123sdsw122'},
    {'id': 13, 'name':'qwe123sdsw123'},
    {'id': 14, 'name':'qwe123sdsw124'},
    {'id': 15, 'name':'qwe123sdsw125'},
  ];

  @Operation.get()
  Future<Response> getAllDevices(@Bind.query('name') String name) async {
    final deviceQuery = Query<Device>(context);

    if (name != null) {
      deviceQuery.where((d) => d.name).contains(name, caseSensitive: false);
    }

      final devices = await deviceQuery.fetch();

    return Response.ok(devices);
  }

  @Operation.get('id')
  Future<Response> getDeviceByID(@Bind.path('id') int id) async {
    final deviceQuery = Query<Device>(context)
        ..where((d) => d.id).equalTo(id);

    final device = await deviceQuery.fetchOne();

    if (device == null) {
      return Response.notFound();
    }

    return Response.ok(device);
  }

  @Operation.post()
  Future<Response> createDevice() async {
    final device = Device()
      ..read(await request.body.decode(), ignore: ["id"]);

    final query = Query<Device>(context)..values = device;

    final insertedDevice = await query.insert();
    return Response.ok(insertedDevice);
  }

//  @Operation.get()
//  Future<Response> getAllDevices() async {
//    return Response.ok(_devices);
//  }
//
//  @Operation.get('id')
//  Future<Response> getDeviceByID(@Bind.path('id') int id) async {
//
//      final device = _devices.firstWhere((device) => device['id'] == id, orElse: null);
//
//      if (device == null) {
//        return Response.notFound();
//      }
//
//      return Response.ok(device);
//  }
}