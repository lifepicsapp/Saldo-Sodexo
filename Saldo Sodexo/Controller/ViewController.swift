//
//  ViewController.swift
//  Saldo Sodexo
//
//  Created by Gabriel Moraes on 05/06/14.
//  Copyright (c) 2014 Gabriel Moraes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrCartoes: [AnyObject]!
    var cartao: Cartao!
    
    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.arrCartoes = Cartao.listaTodos()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "sgCaptcha" {
            var controller = segue.destinationViewController as CaptchaViewController
            controller.cartao = self.cartao
        }
    }
    
    //MARK: TableView Datasource
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.arrCartoes.count
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return self.arrCartoes.count>0 ? "Deslize para apagar" : "Você não possui cartões cadastrados"
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellCartao", forIndexPath: indexPath) as UITableViewCell
        
        var cartao = self.arrCartoes[indexPath.item] as Cartao
        var tipo = Tipo.buscaPorId(cartao.idTipo)
        cell.textLabel.text = cartao.numero + " (\(tipo.descricao))"
        cell.detailTextLabel.text = cartao.cpf
        cell.imageView.image = UIImage(named:tipo.identificador)
        return cell
    }
    
    //MARK: TableView Delegate
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var cartao = self.arrCartoes[indexPath.item] as Cartao
            Cartao.deleta(cartao)
            self.arrCartoes = self.arrCartoes.filter({ cartaoFiltro in
                cartaoFiltro as Cartao != cartao
            })
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.cartao = self.arrCartoes[indexPath.item] as Cartao
        self.performSegueWithIdentifier("sgCaptcha", sender: nil)
    }
    
}

