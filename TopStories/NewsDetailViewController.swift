//
//  NewsDetailViewController.swift
//  TopStories
//
//  Created by Maitree Bain on 11/26/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headlineAbstractionLabel: UITextView!
    @IBOutlet weak var bylineLabel: UILabel!
    
    var newsHeadline: NewsHeadline?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        guard let headline = newsHeadline else {
            fatalError("no headline")
        }
        navigationItem.title = headline.title
        headlineAbstractionLabel.text = headline.abstract
        bylineLabel.text = headline.byline
        
        if let superJumboImage = headline.superJumbo {
            ImageClient.fetchImage(for: superJumboImage.url) { [unowned self] (result) in
                
                switch result{
                case .failure(let error):
                    print("error \(error)")
                case .success(let image):
                    DispatchQueue.main.async {
                        //TODO: UIActivityIndicator() ... shows user an indicator as to the progress of a download
                    self.headlineImageView.image = image
                    }
                }
                
            }
        }
        
    }
}

