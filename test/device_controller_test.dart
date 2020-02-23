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

import 'harness/app.dart';

void main() {
  final harness = Harness()..install();

  test("GET /devices return 401 for unautorised request", () async {

    final response = await harness.agent.get("/devices/1");
    expectResponse(response, 404);
  });


  test("GET /devices after post return 200 OK", () async {
    final resp = await harness.agent.post("/devices", body: {
    "name": "Fred"
    });

    final response = await harness.agent.get("/devices/1");
    expectResponse(response, 200);
  });

  test("POST /devices returns 200 OK", () async {
  final response = await harness.agent.post("/devices", body: {
    "name": "Fred"
  });

  expectResponse(response, 200, body: {
    "id": greaterThan(0),
    "name": "Fred"
  });
  });

  test("POST /devices duble time returns 409", () async {
  await harness.agent.post("/devices", body: {
    "name": "Fred"
  });

  final badResponse = await harness.agent.post("/devices", body: {
    "name": "Fred"
  });
  expectResponse(badResponse, 409);
  });

}