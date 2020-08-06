//
//  ProfileHeader.swift
//  twitterClone
//
//  Created by mohamed elatabany on 8/1/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate: class  {
    func backButtonDidPressed()
}

class ProfileHeader: UICollectionReusableView {
    
    
    // -------------------------------------------------
    // MARK: - Properties
    
    
    
    
    weak var delegate: ProfileHeaderDelegate?
    
    
    private let filterBar = ProfileFilterView()
    
    
    
    
    private lazy var  containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .twitterBlue
        
        view.addSubview(self.backButton)
        self.backButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, paddingTop: 42, paddingLeft: 16)
        self.backButton.setDimensions(width: 30, height: 30)
        
        return view
    }()
    
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(self.handleDismissal), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        iv.layer.cornerRadius = 80/2
        return iv
    }()
    
    lazy var editProfilefollowButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.layer.cornerRadius = 36 / 2
        
        button.addTarget(self, action: #selector(self.handleEditProfileFollow), for: .touchUpInside)
        return button
        
    }()
    
    
    
    
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Mohaemed Elatabany"
        return label
    }()
    
    
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "@Atabany"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes"
        return label
    }()
    
    
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    
    // -------------------------------------------------
    // MARK: -  Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterBar.delegate = self
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, height: 108)
        
        
        
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: containerView.bottomAnchor, leading: leadingAnchor, paddingTop: -24, paddingLeft: 8)
        profileImageView.setDimensions(width: 80, height: 80)
        
        
        addSubview(editProfilefollowButton)
        editProfilefollowButton.anchor(top: containerView.bottomAnchor, trailing: trailingAnchor, paddingTop: 12, paddingRight: 12)
        
        editProfilefollowButton.setDimensions(width: 100, height: 36)
        
        
        
        let userDetailsStackView = UIStackView(arrangedSubviews: [fullNameLabel,userNameLabel, bioLabel])
        userDetailsStackView.axis = .vertical
        userDetailsStackView.distribution = .fillProportionally
        userDetailsStackView.alignment = .fill
        userDetailsStackView.spacing = 4
        self.addSubview(userDetailsStackView)
        
        
        userDetailsStackView.anchor(top: profileImageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
        
        
        addSubview(filterBar)
        
        filterBar.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, height: 50)
        
        
        
        addSubview(underlineView)
        underlineView.anchor(leading: leadingAnchor, bottom: bottomAnchor, width: frame.width / 3, height: 2)
        
        
        
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // -------------------------------------------------
    // MARK: - selectors
    
    @objc
    func handleDismissal() {
        delegate?.backButtonDidPressed()
    }
    
    @objc
    func handleEditProfileFollow() {
        
    }
    
}

// -------------------------------------------------
// MARK: - ProfileFilterviewDelegate
extension ProfileHeader: ProfileFilterviewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {

        let attributesCell = view.collectionView.layoutAttributesForItem(at: indexPath)
        guard let frame = attributesCell?.frame else { return  }
        let frameToSuperView = view.collectionView.convert(frame, to: view.collectionView.superview)

        
        let xPosition = frameToSuperView.centerX
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.centerX = xPosition
        }
        
        
    }
}




















extension CGRect
{
    /** Creates a rectangle with the given center and dimensions
     - parameter center: The center of the new rectangle
     - parameter size: The dimensions of the new rectangle
     */
    init(center: CGPoint, size: CGSize)
    {
        self.init(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
    }
    
    /** the coordinates of this rectangles center */
    var center: CGPoint
    {
        get { return CGPoint(x: centerX, y: centerY) }
        set { centerX = newValue.x; centerY = newValue.y }
    }
    
    /** the x-coordinate of this rectangles center
     - note: Acts as a settable midX
     - returns: The x-coordinate of the center
     */
    var centerX: CGFloat
    {
        get { return midX }
        set { origin.x = newValue - width * 0.5 }
    }
    
    /** the y-coordinate of this rectangles center
     - note: Acts as a settable midY
     - returns: The y-coordinate of the center
     */
    var centerY: CGFloat
    {
        get { return midY }
        set { origin.y = newValue - height * 0.5 }
    }
    
    // MARK: - "with" convenience functions
    
    /** Same-sized rectangle with a new center
     - parameter center: The new center, ignored if nil
     - returns: A new rectangle with the same size and a new center
     */
    func with(center: CGPoint?) -> CGRect
    {
        return CGRect(center: center ?? self.center, size: size)
    }
    
    /** Same-sized rectangle with a new center-x
     - parameter centerX: The new center-x, ignored if nil
     - returns: A new rectangle with the same size and a new center
     */
    func with(centerX: CGFloat?) -> CGRect
    {
        return CGRect(center: CGPoint(x: centerX ?? self.centerX, y: centerY), size: size)
    }
    
    /** Same-sized rectangle with a new center-y
     - parameter centerY: The new center-y, ignored if nil
     - returns: A new rectangle with the same size and a new center
     */
    func with(centerY: CGFloat?) -> CGRect
    {
        return CGRect(center: CGPoint(x: centerX, y: centerY ?? self.centerY), size: size)
    }
    
    /** Same-sized rectangle with a new center-x and center-y
     - parameter centerX: The new center-x, ignored if nil
     - parameter centerY: The new center-y, ignored if nil
     - returns: A new rectangle with the same size and a new center
     */
    func with(centerX: CGFloat?, centerY: CGFloat?) -> CGRect
    {
        return CGRect(center: CGPoint(x: centerX ?? self.centerX, y: centerY ?? self.centerY), size: size)
    }
}
