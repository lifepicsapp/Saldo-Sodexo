//
//  CaptchaViewController.swift
//  Saldo Sodexo
//
//  Created by Gabriel Moraes on 05/06/14.
//  Copyright (c) 2014 Gabriel Moraes. All rights reserved.
//

import UIKit
import Foundation

class CaptchaViewController: UIViewController {
    
    let manager = AFHTTPSessionManager(baseURL: NSURL(string: "https://sodexosaldocartao.com.br/"))
    var cartao: Cartao!
    
    @IBOutlet var txtCaptcha : UITextField!
    @IBOutlet var imgCaptcha : UIImageView!
    @IBOutlet var lblStatus : UILabel!
    @IBOutlet var aiCarregando : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtCaptcha.becomeFirstResponder()
        self.aiCarregando.startAnimating()
        
        self.manager.responseSerializer = AFImageResponseSerializer()
        self.manager.GET("/saldocartao/jcaptcha.do", parameters: nil, success: {task, responseObject in
            self.aiCarregando.stopAnimating()
            self.imgCaptcha.image = responseObject as UIImage
            self.txtCaptcha.text = ""
            },
            failure: {operation, error in
                self.aiCarregando.stopAnimating()
                self.lblStatus.hidden = false
                self.txtCaptcha.text = ""
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "sgSaldo" {
            var controller = segue.destinationViewController as CaptchaViewController
            controller.cartao = self.cartao
        }
    }

    @IBAction func verifica(sender : AnyObject) {
        var params = Dictionary<String, String>()
        params.updateValue(self.cartao.idTipo, forKey: "service")
        params.updateValue(self.cartao.numero, forKey: "cardNumber")
        params.updateValue(self.cartao.cpf, forKey: "cpf")
        params.updateValue(self.txtCaptcha.text, forKey: "jcaptcha_response")
        
        self.manager.responseSerializer = AFHTTPResponseSerializer()
        self.manager.POST("/saldocartao/consultaSaldo.do?operation=consult", parameters: params, success: {task, responseObject in
            println(NSString(data: responseObject as NSData, encoding: NSISOLatin1StringEncoding))
            },
            failure: {operation, error in
                
            }
        )
    }

    @IBAction func cancela(sender : AnyObject) {
        
    }
    
}
