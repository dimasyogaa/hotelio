import 'package:course_hotelio/model/hotel.dart';
import 'package:course_hotelio/source/hotel_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CNearby extends GetxController {
  final _category = 'All Place'.obs;

  String get category => _category.value;

  set category(n) {
    _category.value = n;
    update();
  }

  List<String> get categories => [
    'All Place',
    'Industrial',
    'Village'
  ];

  final _listHotel = <Hotel>[].obs;
  List<Hotel> get listHotel => _listHotel.value;

  getListHotel() async {

    _listHotel.value = await HotelSource.getHotel();

    filterHotels();

    update();

  }

  final _filteredHotels = <Hotel>[].obs;
  List<Hotel> get filteredHotels => _filteredHotels.value;

  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();

  void filterHotels() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      _filteredHotels.value = _listHotel;
    } else {
      _filteredHotels.value = _listHotel
          .where((hotel) => hotel.name.toLowerCase().contains(query) || hotel.location.toLowerCase().contains(query))
          .toList();
    }
    update();
  }


  // initState
  @override
  void onInit() {
    getListHotel();

    //
    searchController.addListener(() {
      filterHotels();
    });

    //
    searchFocusNode.addListener(() {
      if (!searchFocusNode.hasFocus) {
        searchFocusNode.unfocus(); // Unfocus if it loses focus
      }
    });

    super.onInit();
  }


}
