//
//  MemeDetailsViewController.swift
//  MemeMeV2
//
//  Created by Hossameldien Hamada on 7/21/19.
//  Copyright © 2019 Hossameldien Hamada. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var image: UIImageView!
    
    //MARK:- Variables
    var meme: Meme!
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = meme.memedImage
    }
    
    //MARK:- Actions
    @IBAction func editAction(_ sender: Any) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "meme")as! MemeMeController
        controller.hidesBottomBarWhenPushed = true
        controller.originalImage = meme.originalImage
        controller.upperText = meme.topText
        controller.lowerText = meme.bottomText
        controller.calledToEdit = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
