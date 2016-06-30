//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by Keshav Aggarwal on 29/06/16.
//  Copyright © 2016 Harvard Summer School. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {

    @IBOutlet weak var displayText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Problem 4";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func runClicked(sender: AnyObject) {
        displayText.text = "Yeah!! We were clicked 4!!"
        print("Yes..the button was clicked 4!!")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
