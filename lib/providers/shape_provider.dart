import 'package:flutter/material.dart';
import 'package:ososs/providers/base_provider.dart';

import '../constants/constants.dart';
import '../models/shape.dart';

class ShapeProvider extends BaseProvider {
  List<Shape> _shapes = <Shape>[];

  double _radius = 10;
  double get Radius => _radius;

  Color _color = Color(0xff0D47A2);
  Color get color => _color;

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

  void setBorderRadius(double value) {
    _radius = value;
    notifyListeners();
  }

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }
}
