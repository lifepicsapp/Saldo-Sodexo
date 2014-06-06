//
//  ViewController.swift
//  Saldo Sodexo
//
//  Created by Gabriel Moraes on 05/06/14.
//  Copyright (c) 2014 Gabriel Moraes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrCartoes = Cartao.listaTodos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.arrCartoes.count
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return "Selecione um cartão"
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellCartao", forIndexPath: indexPath) as UITableViewCell
        
        var cartao = self.arrCartoes[indexPath.item]
        var tipo = Tipo.tituloPorIdentificador(cartao.idTipo)
        cell.textLabel.text = cartao.numero + " (\(tipo))"
        cell.detailTextLabel.text = cartao.cpf
        return cell
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.performSegueWithIdentifier("sgCaptcha", sender: nil)
    }
    
}

