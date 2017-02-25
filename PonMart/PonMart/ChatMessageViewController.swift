//
//  ChatMessageViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 2/24/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit

class ChatMessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func BackButtonClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "ChatViewToUserMessageView", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
