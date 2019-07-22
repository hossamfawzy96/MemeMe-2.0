//
//  SentMemeTableViewController.swift
//  MemeMeV2
//
//  Created by Hossameldien Hamada on 7/14/19.
//  Copyright © 2019 Hossameldien Hamada. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables
    var memes : [Meme]!
    
    //MARK:- TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! SentMemeTableCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.memeImage.image = meme.memedImage
        cell.memeText.text  = "\(meme.topText)...\(meme.bottomText)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "memeDetail")as! MemeDetailsViewController
        controller.hidesBottomBarWhenPushed = true
        controller.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete){
            getMemesFromAppDelegate((indexPath as NSIndexPath).row)
        }
    }
    
    //MARK:- LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMemesFromAppDelegate()
    }
    
    //MARK:- Actions
    @IBAction func addAction(_ sender: Any) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "meme")as! MemeMeController
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- Functions
    func getMemesFromAppDelegate(_ index: Int = -1){
        if(index != -1){
            MemesSingelton.memes.remove(at:index)
        }
        self.memes = MemesSingelton.memes
        tableView.reloadData()
    }
}
