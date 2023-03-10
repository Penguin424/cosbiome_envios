///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class LoginDataModelUserRole {
/*
{
  "name": "ADMIN",
  "description": "Tiene todo el acceso",
  "type": "admin",
  "id": "5f9f48b252d3950554f25ba1"
} 
*/

  String? name;
  String? description;
  String? type;
  String? id;

  LoginDataModelUserRole({
    this.name,
    this.description,
    this.type,
    this.id,
  });
  LoginDataModelUserRole.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    description = json['description']?.toString();
    type = json['type']?.toString();
    id = json['id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}

class LoginDataModelUser {
/*
{
  "confirmed": true,
  "blocked": false,
  "fechas": false,
  "sucursal": "FEDERALISMO",
  "username": "Pablo Rizo",
  "email": "dev@cosbiome.com",
  "telefono": true,
  "provider": "local",
  "createdAt": "2020-11-04T14:49:30.196Z",
  "updatedAt": "2022-11-01T16:04:20.914Z",
  "role": {
    "name": "ADMIN",
    "description": "Tiene todo el acceso",
    "type": "admin",
    "id": "5f9f48b252d3950554f25ba1"
  },
  "id": "5fa2bf7a9d615005d568686c"
} 
*/

  bool? confirmed;
  bool? blocked;
  bool? fechas;
  String? sucursal;
  String? username;
  String? email;
  bool? telefono;
  String? provider;
  String? createdAt;
  String? updatedAt;
  LoginDataModelUserRole? role;
  String? id;

  LoginDataModelUser({
    this.confirmed,
    this.blocked,
    this.fechas,
    this.sucursal,
    this.username,
    this.email,
    this.telefono,
    this.provider,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.id,
  });
  LoginDataModelUser.fromJson(Map<String, dynamic> json) {
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    fechas = json['fechas'];
    sucursal = json['sucursal']?.toString();
    username = json['username']?.toString();
    email = json['email']?.toString();
    telefono = json['telefono'];
    provider = json['provider']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    role = (json['role'] != null)
        ? LoginDataModelUserRole.fromJson(json['role'])
        : null;
    id = json['id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['confirmed'] = confirmed;
    data['blocked'] = blocked;
    data['fechas'] = fechas;
    data['sucursal'] = sucursal;
    data['username'] = username;
    data['email'] = email;
    data['telefono'] = telefono;
    data['provider'] = provider;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class LoginDataModel {
/*
{
  "jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmYTJiZjdhOWQ2MTUwMDVkNTY4Njg2YyIsImlhdCI6MTY3NjQwODIwMCwiZXhwIjoxNjc5MDAwMjAwfQ.4WVoseDko8IBDREgJ80BL1SLglgHjTWcLamPVngLfak",
  "user": {
    "confirmed": true,
    "blocked": false,
    "fechas": false,
    "sucursal": "FEDERALISMO",
    "username": "Pablo Rizo",
    "email": "dev@cosbiome.com",
    "telefono": true,
    "provider": "local",
    "createdAt": "2020-11-04T14:49:30.196Z",
    "updatedAt": "2022-11-01T16:04:20.914Z",
    "role": {
      "name": "ADMIN",
      "description": "Tiene todo el acceso",
      "type": "admin",
      "id": "5f9f48b252d3950554f25ba1"
    },
    "id": "5fa2bf7a9d615005d568686c"
  }
} 
*/

  String? jwt;
  LoginDataModelUser? user;

  LoginDataModel({
    this.jwt,
    this.user,
  });
  LoginDataModel.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt']?.toString();
    user = (json['user'] != null)
        ? LoginDataModelUser.fromJson(json['user'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jwt'] = jwt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
