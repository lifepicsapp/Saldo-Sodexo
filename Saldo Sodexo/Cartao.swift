//
//  Cartao.swift
//  Saldo Sodexo
//
//  Created by Gabriel Moraes on 05/06/14.
//  Copyright (c) 2014 Gabriel Moraes. All rights reserved.
//

import UIKit
import CoreData

@objc(Cartao)
class Cartao: NSManagedObject {
    @NSManaged var idTipo: String
    @NSManaged var numero: String
    @NSManaged var cpf: String
    
    class func listaTodos() -> NSArray? {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var request = NSFetchRequest(entityName: "Cartao")
        return appDelegate.managedObjectContext.executeFetchRequest(request, error: nil)
    }
    
    class func salva(numero: String, cpf: String, idTipo: String) {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var entity = NSEntityDescription.entityForName("Cartao", inManagedObjectContext: appDelegate.managedObjectContext)
        var cartao = Cartao(entity: entity, insertIntoManagedObjectContext: appDelegate.managedObjectContext)
        cartao.idTipo = idTipo
        cartao.numero = numero
        cartao.cpf = cpf
        appDelegate.saveContext()
    }
}
