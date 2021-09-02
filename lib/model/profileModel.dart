import 'dart:convert';

ProfileList profileListFromJson(String str) =>
    ProfileList.fromJson(json.decode(str));

String profileListToJson(ProfileList data) => json.encode(data.toJson());

class ProfileList {
  ProfileList({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<Profile> data;

  factory ProfileList.fromJson(Map<String, dynamic> json) => ProfileList(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Profile>.from(json["data"].map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Profile {
  Profile({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
