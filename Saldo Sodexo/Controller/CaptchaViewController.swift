//
//  CaptchaViewController.swift
//  Saldo Sodexo
//
//  Created by Gabriel Moraes on 05/06/14.
//  Copyright (c) 2014 Gabriel Moraes. All rights reserved.
//

import UIKit
import Foundation

class CaptchaViewController: UIViewController, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    let manager = AFHTTPSessionManager(baseURL: NSURL(string: "https://sodexosaldocartao.com.br"))
    var cartao: Cartao!
    
    @IBOutlet var txtCaptcha : UITextField
    @IBOutlet var imgCaptcha : UIImageView
    @IBOutlet var lblStatus : UILabel
    @IBOutlet var aiCarregando : UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtCaptcha.becomeFirstResponder()
        
        self.imgCaptcha.image = nil
        self.aiCarregando.startAnimating()
        
        var request = NSMutableURLRequest(URL: NSURL(string: "https://sodexosaldocartao.com.br/saldocartao/jcaptcha.do"))
        //        request.setValue("chunked", forHTTPHeaderField: "Transfer-Encoding")
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        //        request.setValue(self.cartao.idTipo, forHTTPHeaderField: "service")
        //        request.setValue(self.cartao.numero, forHTTPHeaderField: "cardNumber")
        //        request.setValue(self.cartao.cpf, forHTTPHeaderField: "cpf")
        //        request.setValue(self.txtCaptcha.text, forHTTPHeaderField: "jcaptcha_response")
        request.HTTPMethod = "GET"
//        request.HTTPBody = NSData(contentsOfFile: postBody)
        
//        var manager = AFHTTPRequestOperationManager(baseURL:NSURL(string: "https://sodexosaldocartao.com.br/saldocartao/consultaSaldo.do?operation=consult"))
        
        var operation = AFHTTPRequestOperation(request: request)
        operation.responseSerializer = AFImageResponseSerializer()
        operation.setCompletionBlockWithSuccess({operation, responseObject in
            self.aiCarregando.stopAnimating()
                        self.imgCaptcha.image = responseObject as UIImage
                        self.txtCaptcha.text = ""
            }, failure: {operation, error in
                                self.aiCarregando.stopAnimating()
                                self.lblStatus.hidden = false
                                self.txtCaptcha.text = ""
            })
        
        operation.start()
        
//        self.manager.responseSerializer = AFImageResponseSerializer()
//        self.manager.GET("/saldocartao/jcaptcha.do", parameters: nil, success: {task, responseObject in
//            self.aiCarregando.stopAnimating()
//            self.imgCaptcha.image = responseObject as UIImage
//            self.txtCaptcha.text = ""
//            },
//            failure: {operation, error in
//                self.aiCarregando.stopAnimating()
//                self.lblStatus.hidden = false
//                self.txtCaptcha.text = ""
//            })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        var params = Dictionary<String, String>()
        params.updateValue(self.cartao.idTipo, forKey: "service")
        params.updateValue(self.cartao.numero, forKey: "cardNumber")
        params.updateValue(self.cartao.cpf, forKey: "cpf")
        params.updateValue(self.txtCaptcha.text, forKey: "jcaptcha_response")
        
        var postBody = "service=5%3B1%3B6&cardNumber=\(self.cartao.numero)&cpf=\(self.cartao.cpf)&jcaptcha_response=\(self.txtCaptcha.text)"
        
        var request = NSMutableURLRequest(URL: NSURL(string: "https://sodexosaldocartao.com.br/saldocartao/consultaSaldo.do?operation=consult"))
//        request.setValue("chunked", forHTTPHeaderField: "Transfer-Encoding")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.setValue(self.cartao.idTipo, forHTTPHeaderField: "service")
//        request.setValue(self.cartao.numero, forHTTPHeaderField: "cardNumber")
//        request.setValue(self.cartao.cpf, forHTTPHeaderField: "cpf")
//        request.setValue(self.txtCaptcha.text, forHTTPHeaderField: "jcaptcha_response")
        request.HTTPMethod = "POST"
        request.HTTPBody = NSData(contentsOfFile: postBody)
        
        var manager = AFHTTPRequestOperationManager(baseURL:NSURL(string: "https://sodexosaldocartao.com.br/saldocartao/consultaSaldo.do?operation=consult"))
        
        var operation = AFHTTPRequestOperation(request: request)
        operation.responseSerializer = AFHTTPResponseSerializer()
        operation.setCompletionBlockWithSuccess({operation, responseObject in
                        println(operation.response.MIMEType)
                        println(operation.response)
                        println(operation.request)
            
                        println(NSString(data: responseObject as NSData, encoding: NSISOLatin1StringEncoding))
            }, failure: {operation, error in
                println(error.description)
            })
        
        operation.start()
        
//        var serializer = AFHTTPRequestSerializer()
//        serializer.setValue("Mozilla/5.0 (Windows NT 6.1; rv:5.0) Gecko/20100101 Firefox/5.0", forHTTPHeaderField: "User-Agent")
//        self.manager.requestSerializer = serializer
//        self.manager.responseSerializer = AFHTTPResponseSerializer()
//        
//        self.manager.POST("/saldocartao/consultaSaldo.do?operation=consult", parameters: params, success: {task, responseObject in
//            
//            println(task.response.MIMEType)
//            println(task.response)
//            println(task.currentRequest)
//            println(task.originalRequest)
//            
//            println(NSString(data: responseObject as NSData, encoding: NSISOLatin1StringEncoding))
//            },
//            failure: {operation, error in
//                
//            })
    }

    @IBAction func cancela(sender : AnyObject) {
        
    }
    
}
