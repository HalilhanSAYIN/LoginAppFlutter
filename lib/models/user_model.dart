import 'dart:convert';

class UserModel {
    int? id;
    dynamic fname;
    dynamic lname;
    dynamic cname;
    String? role;
    String? photo;
    dynamic gender;
    dynamic birthday;
    dynamic phone;
    String? email;
    String? active;
    dynamic emailVerifiedAt;
    dynamic idRear;
    dynamic idFront;
    dynamic face;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    UserModel({
        this.id,
        this.fname,
        this.lname,
        this.cname,
        this.role,
        this.photo,
        this.gender,
        this.birthday,
        this.phone,
        this.email,
        this.active,
        this.emailVerifiedAt,
        this.idRear,
        this.idFront,
        this.face,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    UserModel copyWith({
        int? id,
        dynamic fname,
        dynamic lname,
        dynamic cname,
        String? role,
        String? photo,
        dynamic gender,
        dynamic birthday,
        dynamic phone,
        String? email,
        String? active,
        dynamic emailVerifiedAt,
        dynamic idRear,
        dynamic idFront,
        dynamic face,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic deletedAt,
    }) => 
        UserModel(
            id: id ?? this.id,
            fname: fname ?? this.fname,
            lname: lname ?? this.lname,
            cname: cname ?? this.cname,
            role: role ?? this.role,
            photo: photo ?? this.photo,
            gender: gender ?? this.gender,
            birthday: birthday ?? this.birthday,
            phone: phone ?? this.phone,
            email: email ?? this.email,
            active: active ?? this.active,
            emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
            idRear: idRear ?? this.idRear,
            idFront: idFront ?? this.idFront,
            face: face ?? this.face,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
        );

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fname: json["fname"],
        lname: json["lname"],
        cname: json["cname"],
        role: json["role"],
        photo: json["photo"],
        gender: json["gender"],
        birthday: json["birthday"],
        phone: json["phone"],
        email: json["email"],
        active: json["active"],
        emailVerifiedAt: json["email_verified_at"],
        idRear: json["id_rear"],
        idFront: json["id_front"],
        face: json["face"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fname": fname,
        "lname": lname,
        "cname": cname,
        "role": role,
        "photo": photo,
        "gender": gender,
        "birthday": birthday,
        "phone": phone,
        "email": email,
        "active": active,
        "email_verified_at": emailVerifiedAt,
        "id_rear": idRear,
        "id_front": idFront,
        "face": face,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
