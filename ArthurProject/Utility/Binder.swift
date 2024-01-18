import UIKit

final class Binder<T> {
    var value: T {
        didSet {
            guard let box = box else { return }
            box(value)
        }
    }
    
    typealias BindBox = (T) -> ()
    private var box: BindBox?
    

    init(value: T) {
        self.value = value
    }
    
    func bindTo(box: @escaping BindBox) {
        self.box = box
        self.box?(value)
    }
    
}
