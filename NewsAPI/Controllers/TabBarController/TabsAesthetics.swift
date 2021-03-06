//
//  TabsAesthetics.swift
//  NewsAPI
//
//  Created by Migy Yabut on 7/30/21.
//

import UIKit

class TabsAesthetics: UIImageView {
    
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(menuItems: [Tabs], frame: CGRect) {
        self.init(frame: frame)
        
        print(frame)
        self.image = UIImage(named: "tab")
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true
        
        for i in 0 ..< menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView = self.createTabItem(item: menuItems[i])
            itemView.tag = i
            
            self.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.widthAnchor.constraint(equalToConstant: itemWidth),
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor),
            ])
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.activateTab(tab: 0)
    }
    func createTabItem(item: Tabs) -> UIView {
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemTitleLabel = UILabel(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        let selectedItemView = UIImageView(frame: CGRect.zero)
                
        tabBarItem.tag = 11
        itemTitleLabel.tag = 12
        itemIconView.tag = 13
        selectedItemView.tag = 14
        
        selectedItemView.image = UIImage(named: "tab")
        selectedItemView.translatesAutoresizingMaskIntoConstraints = false
        selectedItemView.clipsToBounds = true
        tabBarItem.addSubview(selectedItemView)
        NSLayoutConstraint.activate([
            selectedItemView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            selectedItemView.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor, constant: 9),
            selectedItemView.heightAnchor.constraint(equalToConstant: 30),
            selectedItemView.widthAnchor.constraint(equalToConstant: 90)
        ])
        selectedItemView.layer.cornerRadius = 10
        tabBarItem.sendSubviewToBack(selectedItemView)
        selectedItemView.isHidden = true
        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        itemTitleLabel.textColor = .systemBlue
        itemTitleLabel.textAlignment = .left
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.clipsToBounds = true
        itemTitleLabel.isHidden = true
        
        itemIconView.image = item.icon?.withRenderingMode(.automatic)
        itemIconView.contentMode = .scaleAspectFit
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true
        tabBarItem.layer.backgroundColor = UIColor.clear.cgColor
        tabBarItem.addSubview(itemIconView)
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        NSLayoutConstraint.activate([
            itemIconView.heightAnchor.constraint(equalToConstant: 20),
            itemIconView.widthAnchor.constraint(equalToConstant: 20),
            itemIconView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemIconView.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor, constant: -8),
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 13),
            itemTitleLabel.leadingAnchor.constraint(equalTo: itemIconView.trailingAnchor, constant: 2),
            itemTitleLabel.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor, constant: -8)
            ])
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        return tabBarItem
    }
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.switchTab(from: self.activeItem, to: sender.view!.tag)
    }
    func switchTab(from: Int, to: Int) {
        self.deactivateTab(tab: from)
        self.activateTab(tab: to)
    }
    func activateTab(tab: Int) {
        
        let tabToActivate = self.subviews[tab]
        tabToActivate.viewWithTag(12)?.isHidden = false
        tabToActivate.viewWithTag(14)?.isHidden = false
        
        NSLayoutConstraint.deactivate(tabToActivate.constraints.filter({$0.firstItem === tabToActivate.viewWithTag(13) && $0.firstAttribute == .centerX}))
        
        NSLayoutConstraint.activate([tabToActivate.viewWithTag(13)!.centerXAnchor.constraint(equalTo: tabToActivate.centerXAnchor, constant: -20)])
        
        UIView.animate(withDuration: 0.25, animations: {
            tabToActivate.viewWithTag(14)?.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.layoutIfNeeded()
        }) { (Bool) in
            tabToActivate.viewWithTag(14)?.isHidden = false
        }
        self.itemTapped?(tab)
        self.activeItem = tab
    }
    func deactivateTab(tab: Int) {
        let inactiveTab = self.subviews[tab]
        inactiveTab.viewWithTag(12)?.isHidden = true
        NSLayoutConstraint.deactivate(inactiveTab.constraints.filter({$0.firstItem === inactiveTab.viewWithTag(13) && $0.firstAttribute == .centerX}))
        
        NSLayoutConstraint.activate([inactiveTab.viewWithTag(13)!.centerXAnchor.constraint(equalTo: inactiveTab.centerXAnchor)])
        
            self.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, animations: {
            inactiveTab.viewWithTag(14)?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.layoutIfNeeded()
        }) { (Bool) in
            inactiveTab.viewWithTag(14)?.isHidden = true
        }
    }
}

