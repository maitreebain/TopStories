//
//  HeadlineCell.swift
//  TopStories
//
//  Created by Maitree Bain on 11/25/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class HeadlineCell: UITableViewCell {

    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headlineTitle: UILabel!
    @IBOutlet weak var bylineLable: UILabel!

    //add a corner radius on a view, we need to access the layer.cornerRadius property
    //override the layoutSubviews() method
    //layoutSubviews() gets called when the constraints and the view is getting presented in its superview
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //change the cornerRadius of the imageView's layer
        headlineImageView.layer.cornerRadius = 4 //CGFloat
    }
    
    
    func configureCell(for headline: NewsHeadline) {
        headlineTitle.text = headline.title
        bylineLable.text = headline.byline
        
        //image
        if let thumbImage = headline.thumbImage {
         
            // MEMORY MANAGEMENT(ARC) - we need to handle retain cycles here
            // we can achieve this by using a capture list
            // e...g [unownd self] ... more on this later
            ImageClient.fetchImage(for: thumbImage.url) { (result) in
                
                DispatchQueue.main.async {
                    //UI Updates go here
                    switch result {
                    case .success(let image):
                        self.headlineImageView.image = image
                    case .failure(let error):
                        print("configueCell image error - \(error)")
                    }
                }
                
            }
        }
    }
}
