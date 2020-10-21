//
//  HomeTableViewCell.swift
//  ImageMakerDemo
//
//  Created by Benjamin on 20-10-20.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var stackView: UIStackView!
    var titleLabel: UILabel!
    var addressLabel: UILabel!
    var cityLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadViews()
    }
    
    fileprivate func loadViews(){
        titleLabel = {
            let t = UILabel()
            t.font = UIFont.preferredFont(forTextStyle: .headline)
            return t
        }()
        
        addressLabel = {
            let t = UILabel()
            t.font = UIFont.preferredFont(forTextStyle: .body)
            return t
        }()
        
        cityLabel = {
            let t = UILabel()
            t.font = UIFont.preferredFont(forTextStyle: .body)
            return t
        }()
        
        stackView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis  = .vertical
            sv.distribution  = UIStackView.Distribution.fill
            sv.alignment = .leading
            sv.spacing = 8.0
            return sv
        }()
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(cityLabel)
        
        contentView.addSubview(stackView)
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[stackView]-|", options: .alignAllBottom, metrics: nil, views: ["stackView": stackView!]));
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[stackView]-|", options: .alignAllBottom, metrics: nil, views: ["stackView": stackView!]));

    }
    
    func configure(_ cell: PharmacyCell) {
        titleLabel.text = cell.name
        addressLabel.text = cell.address
        cityLabel.text = cell.city
    }

    

}
