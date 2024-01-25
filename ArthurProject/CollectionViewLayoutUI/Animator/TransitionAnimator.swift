import UIKit

final class NavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var storedContext: UIViewControllerContextTransitioning?
    var operation: UINavigationController.Operation
    
    init(operation: UINavigationController.Operation) {
        self.operation = operation
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        storedContext = transitionContext
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to),
              let fromView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let fromFinalFrame = transitionContext.finalFrame(for: fromVC)
        let toFinalFrame = transitionContext.finalFrame(for: toVC)

        if operation == .push {
            
            toView.frame = toFinalFrame.insetBy(dx: -UIScreen.main.bounds.width, dy: 0)
            transitionContext.containerView.addSubview(toView)//must added here
            UIView.animate(withDuration: 0.5) {
                toView.frame = toFinalFrame
            } completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }

        } else if operation == .pop {
            transitionContext.containerView.addSubview(toView)
            
            UIView.animate(withDuration: 0.5) {
                fromView.frame = fromFinalFrame
                toView.frame = toFinalFrame
            } completion: { _ in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }

        }
    }
}
