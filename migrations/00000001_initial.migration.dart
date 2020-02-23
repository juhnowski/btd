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

import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration {

  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_Device", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true)]));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {
    final deviceInventarName = [
      "mvp1234ZX2020#1",
      "mvp1234ZX2020#2",
      "mvp1234ZX2020#3",
      "mvp1234ZX2020#4",
      "mvp1234ZX2020#5",
      "mvp1234ZX2020#6",
      "mvp1234ZX2020#7",
      "mvp1234ZX2020#8",
      "mvp1234ZX2020#9",
      "mvp1234ZX2020#10",
    ];

    for (final deviceName in deviceInventarName) {
      await database.store.execute("INSERT INTO _Device (name) VALUES (@name)", substitutionValues: {
        "name": deviceName
      });
    }
  }
}
    