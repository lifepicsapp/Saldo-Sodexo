//
//  CartaoViewController.swift
//  Saldo Sodexo
//
//  Created by Gabriel Moraes on 05/06/14.
//  Copyright (c) 2014 Gabriel Moraes. All rights reserved.
//

import UIKit
import CoreData

class CartaoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var arrTipos = Tipo.listaTodos()
    var tipo : Tipo!
    
    @IBOutlet var txtNumero : UITextField
    @IBOutlet var txtCpf : UITextField
    @IBOutlet var txtTipo : UITextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        self.txtTipo.inputView = picker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func salvaCartao(sender : AnyObject) {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var entity = NSEntityDescription.entityForName("Cartao", inManagedObjectContext: appDelegate.managedObjectContext)
        var cartao = Cartao(entity: entity, insertIntoManagedObjectContext: appDelegate.managedObjectContext)
        cartao.idTipo = self.tipo.identificador
        cartao.numero = self.txtNumero.text
        cartao.cpf = self.txtCpf.text
        appDelegate.saveContext()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        self.tipo = self.arrTipos.objectAtIndex(0) as Tipo
        self.txtTipo.text = self.tipo.descricao
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return self.arrTipos.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        var tipo = self.arrTipos.objectAtIndex(row) as Tipo
        return tipo.descricao
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        self.tipo = self.arrTipos.objectAtIndex(row) as Tipo
        self.txtTipo.text = self.tipo.descricao
    }

}
