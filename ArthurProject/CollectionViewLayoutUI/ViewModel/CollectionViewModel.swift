import UIKit

//used to represent the data interface used by View, to abstract the data structure 
protocol ShapeData {
    var shapeName: String { get }
    var image: UIImage { get }
}

final class CollectionViewModel {
    
    //default data is here, after adding remote API, make method to request remote data to use
    private let shapes = Shape.makeShapes(
        shapeNames: [.circle, .square, .star, .oval, .triangle, .hexagon])

    lazy var dataSource: Binder<[ShapeData]> = Binder (value: shapes)
    
}
