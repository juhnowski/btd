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

import 'package:btd/btd.dart';

class Device extends ManagedObject<_Device> implements _Device {}

class _Device {
  @primaryKey
  int id;

  @Column(unique: true)
  String name;
}
