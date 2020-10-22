//
//  DetailViewController.swift
//  ImageMakerDemo
//
//  Created by Benjamin on 21-10-20.
//

import UIKit

class DetailViewController: UIViewController {
    
    var stackView: UIStackView!
    var presenter: DetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.presenter?.displayData()
    }
}

extension DetailViewController: DetailUI {
    func displayError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayList(values: [String]) {
        stackView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis  = NSLayoutConstraint.Axis.vertical
            sv.distribution  = UIStackView.Distribution.equalSpacing
            sv.alignment = UIStackView.Alignment.fill
            sv.spacing = 8.0
            return sv
        }()
        
        let titleLabel: UILabel = {
            let l = UILabel()
            l.font = UIFont.preferredFont(forTextStyle: .title1)
            l.textAlignment = .center
            l.text = "Details"
            return l
        }()
        
        stackView.addArrangedSubview(titleLabel)
        
        for value in values {
            let label : UILabel = {
                let l = UILabel()
                l.font = UIFont.preferredFont(forTextStyle: .body)
                l.textAlignment = .left
                l.text = value
                return l
            }()
            stackView.addArrangedSubview(label)
        }
        
        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8).isActive = true
    }
}
