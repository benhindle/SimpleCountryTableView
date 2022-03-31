//
//  LocationTVCellTableViewCell.swift
//  BenHindleFSTest
//
//  Created by Ben Hindle on 1/4/2022.
//

import UIKit

class LocationTVCell: UITableViewCell {
    static let identifier = "LocationTVCell"
    
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let globeIcon: UIImageView = {
        let icon = UIImageView()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: Dimension.standardSFSymbSize, weight: .light, scale: .default)
        let image = UIImage(systemName: "globe.europe.africa.fill", withConfiguration: imageConfig)
        icon.image = image
        icon.contentMode = .center
        icon.tintColor = .gray.withAlphaComponent(0.65)
        return icon
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureDisplay()
        layoutCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Layout config
    func configureDisplay() {
        selectionStyle = .none
        tintColor = .systemGreen.withAlphaComponent(0.65)
        separatorInset = UIEdgeInsets(top: 0, left: Dimension.standardCellHeight, bottom: 0, right: 0)
    }
    
    func layoutCell() {
        self.contentView.addSubview(globeIcon)
        globeIcon.translatesAutoresizingMaskIntoConstraints = false
        globeIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        globeIcon.widthAnchor.constraint(equalToConstant: Dimension.standardCellHeight).isActive = true
        globeIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: globeIcon.trailingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    
    //MARK: - Extensions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        label.font = selected ? UIFont.boldSystemFont(ofSize: 16.0) : UIFont.systemFont(ofSize: 16)
        globeIcon.tintColor = selected ? .systemGreen.withAlphaComponent(0.65) : .gray.withAlphaComponent(0.65)
        accessoryType = selected ? .checkmark : .none
    }
}
