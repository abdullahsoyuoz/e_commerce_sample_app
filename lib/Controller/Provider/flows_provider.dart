import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/Dummy/flows.dart';
import 'package:sepet_demo/Model/flow.dart';

class FlowsProvider with ChangeNotifier {
  late List<FlowEntity> _flows;
  int _currentFilter = 0;

  FlowsProvider() {
    _flows = flowList;
  }

  void setFilterIndex(int index) {
    _currentFilter = index;
    fetchList();
    notifyListeners();
  }

  int getFilterIndex() {
    notifyListeners();
    return _currentFilter;
  }

  void fetchList({FlowType? type}) {
    _flows = [];
    if (_currentFilter == 0) {
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
      for (var element in flowList) {
        if (element.type == FlowType.saved) {
          _flows.add(element);
        }
      }
    }
    notifyListeners();
  }

  List<FlowEntity> getList() =>  _flows;
}
