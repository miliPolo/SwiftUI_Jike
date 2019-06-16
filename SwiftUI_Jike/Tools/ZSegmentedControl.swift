//
//  ZSegmentedControl.swift
//  ZSegmentedControl
//
//  Created by mengqingzheng on 2017/12/6.
//  Copyright © 2017年 MQZHot. All rights reserved.
//

import UIKit
/// both image & text style
public enum HybridStyle {
    case normalWithSpace(CGFloat)
    case imageTopWithSpace(CGFloat)
    case imageBottomWithSpace(CGFloat)
}
/// slider podition
public enum SliderPositionStyle {
    case bottomWithHight(CGFloat)
    case topWidthHeight(CGFloat)
}
/// only text style,
public enum WidthStyle {
    case fixedWidth(CGFloat)
    case adaptiveSpace(CGFloat)
}

public protocol ZSegmentedControlSelectedProtocol: class {
    func segmentedControlSelectedIndex(_ index: Int, animated: Bool, segmentedControl: ZSegmentedControl)
}

public class ZSegmentedControl: UIView {
    
    /// default `false`. if `true`, bounces past edge of content and back again
    public var bounces: Bool = false {
        didSet { scrollView.bounces = bounces }
    }
    /// selected index, default `0`
    public var selectedIndex: Int = 0 {
        didSet { updateScrollViewOffset() }
    }
    /// selectedScale, default `1.0`
    public var selectedScale: CGFloat = 1.0
    /// delegate
    public weak var delegate: ZSegmentedControlSelectedProtocol?
    
// MARK: - set items
    /// only text
    ///
    /// - Parameters:
    ///   - titles: text group
    ///   - style: The width style of the text is an enumeration, fixed width or adaptive
    public func setTitles(_ titles: [String], style: WidthStyle) {
        setTitleItems(titles: titles, style: style)
    }
    
    /// only image
    ///
    /// - Parameters:
    ///   - images: image group
    ///   - selectedImages: selected image group, Ideally the same number of images, if not, the selected will be the item in images
    ///   - fixedWidth: The width is fixed
    public func setImages(_ images: [UIImage], selectedImages: [UIImage?]? = nil, fixedWidth: CGFloat) {
        setImageItems(images: images, selectedImages: selectedImages, fixedWidth: fixedWidth)
    }
    
    /// both text image
    ///
    /// - Parameters:
    ///   - titles: title group
    ///   - images: image group
    ///   - selectedImages: selected image group
    ///   - style: image potision
    ///   - fixedWidth: The width is fixed
    public func setHybridResource(_ titles: [String?], images: [UIImage?], selectedImages: [UIImage?]? = nil, style: HybridStyle = .normalWithSpace(0), fixedWidth: CGFloat) {
        setHybridItems(titles, images: images,selectedImages:selectedImages,style:style, fixedWidth: fixedWidth)
    }
// MARK: - text
    /// textColor
    public var textColor: UIColor = UIColor.gray {
        didSet {
            if itemsArray.count == 0 { return }
            itemsArray.forEach { $0.setTitleColor(textColor, for: .normal) }
            let index = min(max(selectedIndex, 0), itemsArray.count-1)
            let button = itemsArray[index]
            button.setTitleColor(textSelectedColor, for: .normal)
        }
    }
    /// selected textColor
    public var textSelectedColor: UIColor = UIColor.blue {
        didSet {
            if itemsArray.count == 0 { return }
            itemsArray.forEach { $0.setTitleColor(textSelectedColor, for: .normal) }
            let index = min(max(selectedIndex, 0), itemsArray.count-1)
            let button = itemsArray[index]
            button.setTitleColor(textSelectedColor, for: .normal)
        }
    }
    /// textFont
    public var textFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet { itemsArray.forEach { $0.titleLabel?.font = textFont } }
    }
    
// MARK: - setup cover
    
    /// setup cover
    ///
    /// - Parameters:
    ///   - color: color backgroundColor
    ///   - upDowmSpace: the distance of cover's up/down from item's up/down
    ///   - cornerRadius: radius
    public func setCover(color: UIColor, upDowmSpace: CGFloat = 0, cornerRadius: CGFloat = 0) {
        coverView.isHidden = false
        coverView.layer.cornerRadius = cornerRadius
        coverView.backgroundColor = color
        coverUpDownSpace = upDowmSpace
        updateCoverAndSliderFrame(originFrame: coverView.frame, upSpace: upDowmSpace)
    }
    
// MARK: - contentView is scrollView
    
    /// use in contentScrollView `scrollViewDidScroll`
    ///
    /// - Parameter scrollView: content scrollView
    public func contentScrollViewDidScroll(_ scrollView: UIScrollView) {
        updataCoverAndSliderByContentScrollView(scrollView)
    }
    
    /// use in contentScroll `scrollViewWillBeginDragging`
    public func contentScrollViewWillBeginDragging() {
        contentScrollViewWillDragging = true
    }
    
// MARK: - slider
    
    /// set slider
    ///
    /// - Parameters:
    ///   - backgroundColor: slider backgroundColor
    ///   - position: Deciding on the slider position up or down, an enumeration
    ///   - widthStyle: The width of the slider is an enumeration, fixed width or adaptive
    public func setSilder(backgroundColor: UIColor,position: SliderPositionStyle, widthStyle: WidthStyle) {
        var sliderFrame = slider.frame
        switch position {
        case .bottomWithHight(let height):
            sliderFrame.origin.y = frame.size.height-height
            sliderFrame.size.height = height
        case .topWidthHeight(let height):
            sliderFrame.origin.y = 0
            sliderFrame.size.height = height
        }
        slider.frame = sliderFrame
        slider.isHidden = false
        slider.backgroundColor = backgroundColor
        sliderConfig = (position, widthStyle)
    }
    
    /// private
    fileprivate var scrollView = UIScrollView()
    fileprivate var itemsArray = [UIButton]()
    fileprivate var coverView = UIView()
    fileprivate var slider = UIView()
    fileprivate var totalItemsCount: Int = 0
    fileprivate var titleSources = [String]()
    fileprivate var imageSources: ([UIImage], [UIImage]) = ([], [])
    fileprivate var hybridSources: ([String?], [UIImage?], [UIImage?]) = ([], [], [])
    fileprivate var hybridStyle: HybridStyle = .normalWithSpace(0)
    fileprivate var resourceType: ResourceType = .text
    fileprivate var coverUpDownSpace: CGFloat = 0
    fileprivate var sliderConfig: (SliderPositionStyle, WidthStyle) = (.bottomWithHight(2),.adaptiveSpace(0))
    fileprivate var contentScrollViewWillDragging: Bool = false
    fileprivate var isTapItem: Bool = false
    enum ResourceType {
        case text
        case image
        case hybrid
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContentView()
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateScrollViewOffset()
    }
    private func setTitleItems(titles: [String], style: WidthStyle) {
        resourceType = .text
        titleSources = titles
        totalItemsCount = titles.count
        switch style {
        case .fixedWidth(let width):
            setupItems(fixedWidth: width)
        case .adaptiveSpace(let space):
            setupItems(fixedWidth: 0, leading: space)
        }
    }
    private func setImageItems(images: [UIImage], selectedImages: [UIImage?]? = nil, fixedWidth: CGFloat) {
        resourceType = .image
        var sImages = [UIImage]()
        if selectedImages == nil {
            sImages = images
        } else {
            for i in 0..<images.count {
                let image = (i < selectedImages!.count && selectedImages![i] != nil) ? selectedImages![i]! : images[i]
                sImages.append(image)
            }
        }
        imageSources = (images, sImages)
        totalItemsCount = images.count
        setupItems(fixedWidth: fixedWidth)
    }
    private func setHybridItems(_ titles: [String?], images: [UIImage?], selectedImages: [UIImage?]? = nil, style: HybridStyle = .normalWithSpace(0), fixedWidth: CGFloat) {
        resourceType = .hybrid
        hybridStyle = style
        totalItemsCount = max(titles.count, images.count)
        var _titles = [String?]()
        var _images = [UIImage?]()
        var _sImages = [UIImage?]()
        let sTempImages = selectedImages == nil ? images : selectedImages!
        for i in 0..<totalItemsCount {
            let title = i<titles.count ? titles[i] : nil
            let image = i<images.count && images[i] != nil ? images[i] : UIImage()
            let sImage = i<sTempImages.count && sTempImages[i] != nil ? sTempImages[i] : image
            _titles.append(title)
            _images.append(image)
            _sImages.append(sImage)
        }
        hybridSources = (_titles, _images, _sImages)
        setupItems(fixedWidth: fixedWidth)
    }
}
/// setup UI
extension ZSegmentedControl {
    fileprivate func setupContentView() {
        backgroundColor = UIColor.white
        scrollView.frame = bounds
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        addSubview(scrollView)
        scrollView.addSubview(coverView)
        scrollView.addSubview(slider)
        slider.isHidden = true
        coverView.isHidden = true
    }
    
    fileprivate func setupItems(fixedWidth: CGFloat, leading: CGFloat? = nil) {
        itemsArray.forEach { $0.removeFromSuperview() }
        itemsArray.removeAll()
        var contentSizeWidth: CGFloat = 0
        for i in 0..<totalItemsCount {
            var width = fixedWidth
            if let leading = leading {
                let text = titleSources[i] as NSString
                width = text.size(withAttributes: [.font: textFont]).width + leading*2
            }
            let x = contentSizeWidth
            let height = frame.size.height
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: x, y: 0, width: width, height: height)
            button.clipsToBounds = true
            button.tag = i
            button.addTarget(self, action: #selector(selectedButton(sender:)), for: .touchUpInside)
            scrollView.addSubview(button)
            itemsArray.append(button)
            
            switch resourceType {
            case .text:
                button.setTitle(titleSources[i], for: .normal)
                button.setTitleColor(textColor, for: .normal)
                button.titleLabel?.font = textFont
            case .image:
                button.setImage(imageSources.0[i], for: .normal)
                button.setImage(imageSources.1[i], for: .selected)
            case .hybrid:
                button.setTitleColor(textColor, for: .normal)
                button.titleLabel?.font = textFont
                let text = hybridSources.0[i]
                let image = hybridSources.1[i]
                button.setTitle(text, for: .normal)
                button.setImage(image, for: .normal)
                button.setImage(hybridSources.2[i], for: .selected)
                switch hybridStyle {
                case .normalWithSpace(let space):
                    if text == nil || image == nil { break }
                    let distance = space/2
                    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -distance, bottom: 0, right: distance)
                    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: distance, bottom: 0, right: -distance)
                case .imageTopWithSpace(let space):
                    if text == nil || image == nil { break }
                    let distance = space/2
                    let titleWidth = text?.size(withAttributes: [.font: textFont]).width ?? 0
                    let titleHeight = text?.size(withAttributes: [.font: textFont]).height ?? 0
                    button.imageEdgeInsets = UIEdgeInsets(top: -titleHeight-distance, left: 0, bottom: 0, right: -titleWidth)
                    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -image!.size.width, bottom: -image!.size.height-distance, right: 0)
                case .imageBottomWithSpace(let space):
                    if text == nil || image == nil { break }
                    let distance = space/2
                    let titleWidth = text?.size(withAttributes: [.font: textFont]).width ?? 0
                    let titleHeight = text?.size(withAttributes: [.font: textFont]).height ?? 0
                    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -titleHeight-distance, right: -titleWidth)
                    button.titleEdgeInsets = UIEdgeInsets(top: -image!.size.height-distance, left: -image!.size.width, bottom: 0, right: 0)
                }
            }
            contentSizeWidth += width
        }
        scrollView.contentSize = CGSize(width: contentSizeWidth, height: 0)
        let index = min(max(selectedIndex, 0), itemsArray.count-1)
        let selectedButton = itemsArray[index]
        selectedButton.isSelected = true
        updateCoverAndSliderFrame(originFrame: selectedButton.frame, upSpace: coverUpDownSpace)
    }
    @objc private func selectedButton(sender: UIButton) {
        contentScrollViewWillDragging = false
        isTapItem = true
        selectedIndex = sender.tag
    }
}
/// update offset
extension ZSegmentedControl {
    fileprivate func updateScrollViewOffset() {
        if itemsArray.count == 0 { return }
        let index = min(max(selectedIndex, 0), itemsArray.count-1)
        delegate?.segmentedControlSelectedIndex(index, animated: isTapItem, segmentedControl: self)
        
        let currentButton = self.itemsArray[index]
        let offset = getScrollViewCorrectOffset(by: currentButton)
        let duration = isTapItem || contentScrollViewWillDragging
            ? 0.3 : 0
        isTapItem = false
        UIView.animate(withDuration: duration, animations: {
            self.itemsArray.forEach({ (button) in
                button.setTitleColor(self.textColor, for: .normal)
                button.isSelected = false
                button.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            self.updateCoverAndSliderFrame(originFrame: currentButton.frame, upSpace: self.coverUpDownSpace)
            currentButton.setTitleColor(self.textSelectedColor, for: .normal)
            currentButton.isSelected = true
            let scale = self.selectedScale
            currentButton.transform = CGAffineTransform(scaleX: scale, y: scale)
            let animated = duration == 0 ? false:true
            self.scrollView.setContentOffset(offset, animated: animated)
        })
    }
    fileprivate func getScrollViewCorrectOffset(by item: UIButton) -> CGPoint {
        if scrollView.contentSize.width < scrollView.frame.size.width {
            return CGPoint.zero
        }
        var offsetx = item.center.x - frame.size.width/2
        let offsetMax = scrollView.contentSize.width - frame.size.width
        if offsetx < 0 {
            offsetx = 0
        }else if offsetx > offsetMax {
            offsetx = offsetMax
        }
        let offset = CGPoint(x: offsetx, y: 0)
        return offset
    }
}
extension ZSegmentedControl {
    fileprivate func updataCoverAndSliderByContentScrollView(_ scrollView: UIScrollView) {
        if !contentScrollViewWillDragging { return }
        let offset = scrollView.contentOffset.x / scrollView.frame.size.width
        let percent = offset-CGFloat(Int(offset))
        let currentIndex = Int(offset)
        var targetIndex = currentIndex
        if percent < 0 && currentIndex > 0 {
            targetIndex = currentIndex-1
        } else if percent > 0 && currentIndex < itemsArray.count-1 {
            targetIndex = currentIndex+1
        } else {
            return
        }
        let currentButton = itemsArray[currentIndex]
        let targentButton = itemsArray[targetIndex]
        currentButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        targentButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        let centerXChange = (targentButton.center.x-currentButton.center.x)*abs(percent)
        let widthChange = (targentButton.frame.size.width-currentButton.frame.size.width)*abs(percent)
        var frame = currentButton.frame
        frame.size.width += widthChange
        updateCoverAndSliderFrame(originFrame: frame, upSpace: coverUpDownSpace)
        var center = currentButton.center
        center.x += centerXChange
        coverView.center = center
        
        var sliderCenter = slider.center
        sliderCenter.x = coverView.center.x
        slider.center = sliderCenter
        
        /// scale
        let scale = (selectedScale-1)*abs(percent)
        let targetTx = 1 + scale
        let currentTx = selectedScale - scale
        currentButton.transform = CGAffineTransform(scaleX: currentTx, y: currentTx)
        targentButton.transform = CGAffineTransform(scaleX: targetTx, y: targetTx)
        
        let currentColor = averageColor(fromColor: textSelectedColor, toColor: textColor, percent: abs(percent))
        let targetColor = averageColor(fromColor: textColor, toColor: textSelectedColor, percent: abs(percent))
        currentButton.setTitleColor(currentColor, for: .normal)
        targentButton.setTitleColor(targetColor, for: .normal)
    }
    
    fileprivate func updateCoverAndSliderFrame(originFrame: CGRect, upSpace: CGFloat) {
        var newFrame = originFrame
        newFrame.origin.y = upSpace
        newFrame.size.height -= upSpace*2
        coverView.frame = newFrame
        
        switch sliderConfig.0 {
        case .topWidthHeight(let height):
            newFrame.origin.y = 0
            newFrame.size.height = height
        case .bottomWithHight(let height):
            newFrame.origin.y = originFrame.size.height-height
            newFrame.size.height = height
        }
        switch sliderConfig.1 {
        case .fixedWidth(let width):
            newFrame.size.width = width
        case .adaptiveSpace(let space):
            newFrame.size.width = originFrame.size.width-2*space
        }
        slider.frame = newFrame
        
        var sliderCenter = slider.center
        sliderCenter.x = coverView.center.x
        slider.center = sliderCenter
    }
}

/// average
extension ZSegmentedControl {
    fileprivate func averageColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> UIColor {
        var fromRed: CGFloat = 0
        var fromGreen: CGFloat = 0
        var fromBlue: CGFloat = 0
        var fromAlpha: CGFloat = 0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        
        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        
        let nowRed = fromRed + (toRed - fromRed) * percent
        let nowGreen = fromGreen + (toGreen - fromGreen) * percent
        let nowBlue = fromBlue + (toBlue - fromBlue) * percent
        let nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percent
        
        return UIColor(red: nowRed, green: nowGreen, blue: nowBlue, alpha: nowAlpha)
    }
}
