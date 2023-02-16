class GetTable {
  int? id;
  String? name;

  GetTable({
    this.id,
    this.name,
  });
  GetTable.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class GetTableModel {
  int? tableId;
  String? title;
  List<GetTable>? list;

  GetTableModel({
    this.tableId,
    this.title,
    this.list,
  });
  GetTableModel.fromJson(Map<String, dynamic> json) {
    tableId = json['table_id']?.toInt();
    title = json['title']?.toString();
    if (json['list'] != null) {
      final v = json['list'];
      final arr0 = <GetTable>[];
      v.forEach((v) {
        arr0.add(GetTable.fromJson(v));
      });
      list = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['table_id'] = tableId;
    data['title'] = title;
    if (list != null) {
      final v = list;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v.toJson());
      }
      data['list'] = arr0;
    }
    return data;
  }
}
