//
//  Cartao.swift
//  Saldo Sodexo
//
//  Created by Gabriel Moraes on 05/06/14.
//  Copyright (c) 2014 Gabriel Moraes. All rights reserved.
//

import UIKit
import CoreData

class Cartao: NSManagedObject {
    @NSManaged var idTipo: String
    @NSManaged var numero: String
    @NSManaged var cpf: String
    
    class func listaTodos() -> Cartao[] {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var request = NSFetchRequest(entityName:"Cartao")
        var error: NSErrorPointer
        var arrCartoes = appDelegate.managedObjectContext.executeFetchRequest(request, error: nil) as Cartao[]
        return arrCartoes
    }
}
