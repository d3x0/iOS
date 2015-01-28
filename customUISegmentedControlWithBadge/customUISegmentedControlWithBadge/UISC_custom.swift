//
//  UISC_custom.swift
//  customUISegmentedControlWithBadge
//
//  Created by Adrian Nugraha on 1/27/15.
//  Copyright (c) 2015 d3x0 Labs. All rights reserved.
//

import UIKit

class UISC_custom: UISegmentedControl {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    private var segmentWidth: [CGFloat] = [0.0]
    
    private var segmentBadge: [UILabel] = [UILabel()]
    private var segmentBadgeShown: [Bool] = [false]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
/*
        println("super.numberOfSegments=\(super.numberOfSegments)")
        
        if(super.numberOfSegments > 0)
        {
            for(var i: Int = 0; i < super.numberOfSegments; i++)
            {
                println("super.widthForSegmentAtIndex(\(i))=\(super.widthForSegmentAtIndex(i))")
                
            }
        }
*/
        calculateWidths()
        super.tintColor = UIColor.blueColor()
    }
    
    private func calculateWidths()
    {
        if(super.numberOfSegments > 0)
        {
            //println("super.bounds.width=\(super.bounds.width)")
            
            var superWidth: CGFloat = super.bounds.width
            var sumWidth: CGFloat = 0
            var nDivider: CGFloat = 0
            
            for(var i: Int = 0; i < super.numberOfSegments; i++)
            {
                sumWidth = sumWidth + super.widthForSegmentAtIndex(i)
                
                if(super.widthForSegmentAtIndex(i) == 0.0)
                {
                    nDivider++
                }
            }
            
            
            var eachWidth: CGFloat = 0
            var restWidth: CGFloat = superWidth - sumWidth
            
            if(restWidth > 0)
            {
                if(nDivider > 0)
                {
                    eachWidth = restWidth / nDivider
                }
            }
            
            
            segmentWidth.removeAll(keepCapacity: false)
            segmentBadge.removeAll(keepCapacity: false)
            segmentBadgeShown.removeAll(keepCapacity: false)
            
            
            for(var i: Int = 0; i < super.numberOfSegments; i++)
            {
                if(super.widthForSegmentAtIndex(i) > 0.0)
                {
                    //println("super.widthForSegmentAtIndex(\(i))=\(super.widthForSegmentAtIndex(i))")
                    segmentWidth.append(super.widthForSegmentAtIndex(i))
                }
                else
                {
                    //println("super.widthForSegmentAtIndex(\(i))=\(eachWidth)")
                    segmentWidth.append(eachWidth)
                }
                
                segmentBadge.append(UILabel())
                segmentBadgeShown.append(false)
            }
        }
    }
    
    private func getWidthToSegment(segment: Int) -> CGFloat
    {
        var sumWidth: CGFloat = 0
        
        if(segment < super.numberOfSegments)
        {
            for(var i: Int = 0; i <= segment; i++)
            {
                sumWidth = sumWidth + segmentWidth[i]
            }
        }
        
        return sumWidth
    }
    
    func badgeForSegmentAtIndex(segment: Int, badge: String)
    {
        var badgeString: String!
        
        if(countElements(badge) > 2)
        {
            badgeString = "!"
        }
        else
        {
            badgeString = badge
        }
        
        if(segment < super.numberOfSegments)
        {
            var badgeLabel: UILabel = segmentBadge[segment]
            
            badgeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 11)
            badgeLabel.text = badgeString
            badgeLabel.textAlignment = NSTextAlignment.Center
            badgeLabel.textColor = UIColor.whiteColor()
            badgeLabel.backgroundColor = UIColor.redColor()
            badgeLabel.layer.masksToBounds = true
            badgeLabel.layer.cornerRadius = 9
            badgeLabel.frame = CGRectMake(self.frame.origin.x + getWidthToSegment(segment) - 22, self.frame.origin.y - 12, 18, 18)
            
            
            
            if(segmentBadgeShown[segment] == false)
            {
                segmentBadgeShown[segment] = true
                
                superview?.addSubview(badgeLabel)
                superview?.bringSubviewToFront(badgeLabel)
                
                println("index=\(segment) has width=\(segmentWidth[segment]) has badge=\(badge)")
            }
            else
            {
                badgeLabel.removeFromSuperview()
                
                superview?.addSubview(badgeLabel)
                superview?.bringSubviewToFront(badgeLabel)
                
                println("index=\(segment) has width=\(segmentWidth[segment]) refresh to badge=\(badge)")
            }
        }
    }
    
    func removeBadgeAtSegmentIndex(segment: Int)
    {
        if(segment < super.numberOfSegments)
        {
            var badgeLabel: UILabel = segmentBadge[segment]
            badgeLabel.removeFromSuperview()
            
            segmentBadgeShown[segment] = false
        }
    }
}
