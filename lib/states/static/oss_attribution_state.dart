import 'package:zsdemo_app/common/enums/enums.dart';
import 'package:zsdemo_app/models/oss_attributes.dart';
import 'package:zsdemo_app/states/base_state.dart';

enum OSSAttributesSortField { name, license }

class OSSAttributionState extends BaseState {
  OSSAttributionState() : super(busy: true) {
    data.add(const OSSAttribute("React", "MIT License", "https://reactjs.org"));
    data.add(const OSSAttribute("Flutter", "MIT License", "https://flutter.dev"));
    data.add(const OSSAttribute("Kotlin", "BDM License", "https://kotlin.com"));
    data.add(const OSSAttribute("Name", "License", "https://url.url"));
    data.add(const OSSAttribute("React", "MIT License", "https://reactjs.org"));
    data.add(const OSSAttribute("Flutter", "MIT License", "https://flutter.dev"));
    data.add(const OSSAttribute("Kotlin", "BDM License", "https://kotlin.com"));
    data.add(const OSSAttribute("Name", "License", "https://url.url"));
    data.add(const OSSAttribute("React", "MIT License", "https://reactjs.org"));
    data.add(const OSSAttribute("Flutter", "MIT License", "https://flutter.dev"));
    data.add(const OSSAttribute("Kotlin", "BDM License", "https://kotlin.com"));
    data.add(const OSSAttribute("Name", "License", "https://url.url"));
    data.add(const OSSAttribute("React", "MIT License", "https://reactjs.org"));
    data.add(const OSSAttribute("Flutter", "MIT License", "https://flutter.dev"));
    data.add(const OSSAttribute("Kotlin", "BDM License", "https://kotlin.com"));
    data.add(const OSSAttribute("Name", "License", "https://url.url"));
    data.add(const OSSAttribute("React", "MIT License", "https://reactjs.org"));
    data.add(const OSSAttribute("Flutter", "MIT License", "https://flutter.dev"));
    data.add(const OSSAttribute("Kotlin", "BDM License", "https://kotlin.com"));
    data.add(const OSSAttribute("Name", "License", "https://url.url"));
    data.add(const OSSAttribute("React", "MIT License", "https://reactjs.org"));
    data.add(const OSSAttribute("Flutter", "MIT License", "https://flutter.dev"));
    data.add(const OSSAttribute("Kotlin", "BDM License", "https://kotlin.com"));
    data.add(const OSSAttribute("Name", "License", "https://url.url"));
    data.add(const OSSAttribute("React", "MIT License", "https://reactjs.org"));
    data.add(const OSSAttribute("Flutter", "MIT License", "https://flutter.dev"));
    data.add(const OSSAttribute("Kotlin", "BDM License", "https://kotlin.com"));
    data.add(const OSSAttribute("Name", "License", "https://url.url"));
  }

  int get batchSize => 20;

  void onSort(int sortColumn, SortOrder order) {
    _sortColumn = sortColumn;
    _order = order;
    sortData();
    // busyFetch();
  }

  OSSAttributesSortField get sortField {
    switch (sortColumn) {
      case 0:
        return OSSAttributesSortField.name;
      default:
        return OSSAttributesSortField.license;
    }
  }

  int _sortColumn = 0;

  int get sortColumn => _sortColumn;

  SortOrder _order = SortOrder.accending;

  SortOrder get order => _order;

  List<OSSAttribute> data = [];

  void sortData() {
    List<OSSAttribute> newData = data;
    if (sortColumn == 0) {
      if (order == SortOrder.accending) {
        newData.sort(((a, b) => a.name.compareTo(b.name)));
      } else {
        newData.sort(((a, b) => b.name.compareTo(a.name)));
      }
    } else {
      if (order == SortOrder.accending) {
        newData.sort(((a, b) => a.licence.compareTo(b.licence)));
      } else {
        newData.sort(((a, b) => b.licence.compareTo(a.licence)));
      }
    }
    data = newData;
    notifyListeners();
  }
}
