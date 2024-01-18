import UIKit

enum ShapeName: String {
  case circle, square, star, oval, triangle, hexagon
}

struct Shape: ShapeData {
  var shapeName: String
  var image: UIImage
  
  init(shapeName: ShapeName) {
    self.shapeName = shapeName.rawValue
    let imageName = shapeName.rawValue
    guard let image = UIImage(named: shapeName.rawValue)
      else { fatalError("Missing \(imageName) image asset.") }
    self.image = image
  }
  
  static func makeShapes(shapeNames: [ShapeName]) -> [ShapeData] {
    return shapeNames.map { Shape(shapeName: $0) }
  }
}
