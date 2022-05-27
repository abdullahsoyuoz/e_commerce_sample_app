// ignore_for_file: prefer_final_fields, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/Dummy/flows.dart';
import 'package:sepet_demo/Model/flow.dart';

class FlowsProvider with ChangeNotifier {
  late List<FlowEntity> _flows = [];
  late List<FlowEntity> _followedFlows = [];
  late int _currentFilter = 0;
  late bool isLoading = false;
  late bool isAllLoaded = false;
  late int _count = 0;
  late int _step = 0;

  FlowsProvider() {
    filterList();
    // fetchData();
  }

  void setFilterIndex(int index) {
    _currentFilter = index;
    _flows = [];
    _count = 0;
    _step = 0;
    // fetchData();
    filterList();
    notifyListeners();
  }

  void filterList() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    _flows = [];
    _followedFlows;
    if (_currentFilter == 0) {
      flowList.shuffle();
      _flows = flowList;
    }
    if (_currentFilter == 1) {
      for (var element in flowList) {
        if (element.type == FlowType.personal) {
          _flows.add(element);
        }
      }
    }
    if (_currentFilter == 2) {
      for (var element in flowList) {
        if (element.type == FlowType.list) {
          _flows.add(element);
        }
      }
    }
    if (_currentFilter == 3) {
      for (var element in flowList) {
        if (element.type == FlowType.discount) {
          _flows.add(element);
        }
      }
    }
    if (_currentFilter == 4) {
      for (var element in flowList) {
        if (element.type == FlowType.campagne) {
          _flows.add(element);
        }
      }
    }
    if (_currentFilter == 5) {
      _flows = _followedFlows;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchData() async {
    isLoading = true;
    await Future.delayed(const Duration(milliseconds: 1000));

    // if (_flows.length != flowList.length) {
    if (_currentFilter == 0) {
      if (_flows.length != flowList.length) {
        _count = 0;
        for (var element in flowList) {
          if (_count < 10) {
            _flows.add(element);
            _count++;
          }
        }
        _step + 10;
      }
      if (_flows.length == flowList.length) {
        isAllLoaded = true;
        isLoading = false;
      }
    }
    if (_currentFilter != 0) {
      int intermLength = 0;
      for (var item in flowList) {
        if (item.type == getType()) {
          intermLength + 1;
        }
      }

      _count = 0;
      for (var element in flowList) {
        if (element.type == await getType()) {
          if (_count < 10) {
            _flows.add(element);
            _count++;
          }
        }
      }

      _step + 10;
    }
    if (_currentFilter == 5) {
      _flows = _followedFlows;
    }
    // if (_currentFilter != 0) {
    //   await Future.delayed(const Duration(milliseconds: 2000));
    //   for (var element in flowList) {
    //     if (element.type == await getType()) {
    //       if (_count < 10) {
    //         _flows.insert(_step + _count, element);
    //         _count++;
    //       }
    //     }
    //   }
    // }
    // if (_currentFilter == 5) {
    //   _flows = _followedFlows;
    // }
    // } else {
    //   _isAllLoaded = true;
    // }

    isLoading = false;
    notifyListeners();
  }

  Future<FlowType> getType() async {
    switch (_currentFilter) {
      case 1:
        return FlowType.personal;
      case 2:
        return FlowType.list;
      case 3:
        return FlowType.discount;
      case 4:
        return FlowType.campagne;
      default:
        return FlowType.saved;
    }
  }

  Future<List<FlowEntity>> getList() async => await _flows;

  // FOLLOW

  Future<bool> followedListToggleItem(FlowEntity data) async {
    if (!isFollowed(data)) {
      _followedFlows.add(data);
      notifyListeners();
      return true;
    } else {
      _followedFlows.remove(data);
      notifyListeners();
      return false;
    }
  }

  bool isFollowed(FlowEntity data) {
    return _followedFlows.contains(data) ? true : false;
  }
}
