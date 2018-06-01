//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    var cardView: UIView!
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x3700B3)
        
        cardView = UIView()
        view.addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        cardView.backgroundColor = UIColor(rgb: 0x03DAC5)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateCornerChange(recognizer:)))
        cardView.addGestureRecognizer(tapRecognizer)
        
        self.view = view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        cardView.roundCorners(cornerRadius: 20.0)
    }
    
    @objc func animateCornerChange(recognizer: UITapGestureRecognizer) {
        let targetRadius: CGFloat = (cardView.layer.cornerRadius == 0.0) ? 100 : 0.0
//        UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
//            self.cardView.layer.cornerRadius = targetRadius
//        }.startAnimation()
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.cardView.layer.cornerRadius = targetRadius
        }, completion: nil)
    }
}

extension UIView {
    func roundCorners(cornerRadius: Double) {
        
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = CGFloat(cornerRadius)
            self.clipsToBounds = true
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
        
        
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF)
    }
}

PlaygroundPage.current.liveView = MyViewController()

