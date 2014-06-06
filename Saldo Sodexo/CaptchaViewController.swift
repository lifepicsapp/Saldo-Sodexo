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
    var cartao : Cartao!
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "sgSaldo" {
            var controller = segue.destinationViewController as CaptchaViewController
            controller.cartao = self.cartao
        }
    }

    @IBAction func verifica(sender : AnyObject) {
        var manager = AFHTTPRequestOperationManager()
        
        var params = Dictionary<String, String>()
        params.updateValue(self.cartao.idTipo, forKey: "service")
        params.updateValue(self.cartao.numero, forKey: "cardNumber")
        params.updateValue(self.cartao.cpf, forKey: "cpf")
        params.updateValue(self.txtCaptcha.text, forKey: "jcaptcha_response")
        params.updateValue("11", forKey: "x")
        params.updateValue("10", forKey: "y")
        
        var url = self.baseUrl + "/consultaSaldo.do?operation=consult"
    }

    @IBAction func cancela(sender : AnyObject) {
        
    }
    
}
