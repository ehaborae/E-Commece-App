class CategoriesModel{
  late bool status;
  CategoriesData? date;
  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    date = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData{
  late int currentPage;
  late List<Data> data = [];
  CategoriesData.fromJson(Map<String,dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data{
  late int id;
  late String name;
  late String image;
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}