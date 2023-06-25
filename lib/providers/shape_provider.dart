import 'package:ososs/providers/base_provider.dart';

import '../constants/constants.dart';
import '../models/shape.dart';

class ShapeProvider extends BaseProvider {
  List<Shape> _shapes = <Shape>[];
  List<Shape> get Shapes => _shapes;

  Shape _selectedShape = Shape.empty();
  Shape get SelectedShape => _selectedShape;

  void getAllShapes() {
    _shapes = <Shape>[];
    _shapes.add(Shape(id: '1', name: Constants.CIRCLE));
    _shapes.add(Shape(id: '2', name: Constants.RECTANGLE));
    _shapes.add(Shape(id: '3', name: Constants.CURVERECTANGLE));
    notifyListeners();
  }

  void setSelectedShape(Shape shape) {
    if (shape != null && shape.id.isNotEmpty && shape.name.isNotEmpty) {
      _selectedShape = shape!;
    }
    notifyListeners();
  }
}
