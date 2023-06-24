import 'package:ososs/providers/base_provider.dart';

import '../models/shape.dart';

class ShapeProvider extends BaseProvider {
  final List<Shape> _shapes = <Shape>[];
  List<Shape> get Shapes => _shapes;

  void getAllShapes() {
    _shapes.add(Shape(id: '1', name: ''));
    _shapes.add(Shape(id: '2', name: ''));
    _shapes.add(Shape(id: '3', name: ''));
    notifyListeners();
  }
}
