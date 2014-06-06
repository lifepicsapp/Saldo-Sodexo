//
//  CaptchaViewController.swift
//  Saldo Sodexo
//
//  Created by Gabriel Moraes on 05/06/14.
//  Copyright (c) 2014 Gabriel Moraes. All rights reserved.
//

import UIKit

class CaptchaViewController: UIViewController {
    
    let baseUrl = "https://sodexosaldocartao.com.br/saldocartao"
    
    @IBOutlet var txtCaptcha : UITextField
    @IBOutlet var imgCaptcha : UIImageView
    @IBOutlet var lblStatus : UILabel
    @IBOutlet var aiCarregando : UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtCaptcha.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.imgCaptcha.image = nil
        self.aiCarregando.startAnimating()
        var url = NSURL(string: self.baseUrl + "/jcaptcha.do")
        var operation = AFHTTPRequestOperation(request: NSURLRequest(URL: url))
        operation.responseSerializer = AFImageResponseSerializer()
        operation.setCompletionBlockWithSuccess({operation, responseObject in
            self.aiCarregando.stopAnimating()
            self.imgCaptcha.image = responseObject as UIImage
            self.txtCaptcha.text = ""
            },
            failure: {operation, error in
                self.aiCarregando.stopAnimating()
                self.lblStatus.hidden = false
                self.txtCaptcha.text = ""
            }
        )
        operation.start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func verifica(sender : AnyObject) {
    }

    @IBAction func cancela(sender : AnyObject) {
        
    }
    
}
