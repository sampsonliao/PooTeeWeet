//
//  TweetViewController.swift
//  Twitter
//
//  Created by Sampson Liao on 2/18/19.
//

import UIKit
import RSKPlaceholderTextView



class TweetViewController: UIViewController, UITextViewDelegate {

    
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    
    @IBOutlet weak var charCountTextView: UILabel!
    
    var textView: RSKPlaceholderTextView!
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 140
        
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        self.charCountTextView.text = "\(String(newText.count))/140"
        if newText.count < characterLimit {
            self.charCountTextView.textColor = UIColor.black
        } else {
            self.charCountTextView.textColor = UIColor.red
        }
        return newText.count < characterLimit
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        
        self.textView = RSKPlaceholderTextView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        self.textView.placeholder = "Say something..."
        self.tweetTextView.addSubview(self.textView)
        
        textView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                print("Error posting tweet \(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
