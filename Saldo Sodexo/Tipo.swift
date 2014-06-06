//
//  Tipo.swift
//  Saldo Sodexo
//
//  Created by Gabriel Moraes on 05/06/14.
//  Copyright (c) 2014 Gabriel Moraes. All rights reserved.
//

import UIKit

class Tipo: NSObject {
    var id: Int!
    var descricao:String!
    var identificador:String!
    
    init() {
        super.init()
    }
    
    class func listaTodos() -> NSArray {
        var arrTipos = NSMutableArray()
        
        var tipo = Tipo()
        tipo.descricao = "Refeição Pass"
        tipo.identificador = "5;1;6"
        arrTipos.addObject(tipo)
        tipo = Tipo()
        tipo.descricao = "Alimentação Pass"
        tipo.identificador = "5;2;4"
        arrTipos.addObject(tipo)
        tipo = Tipo()
        tipo.descricao = "Gift Pass"
        tipo.identificador = "5;26;4"
        arrTipos.addObject(tipo)
        tipo = Tipo()
        tipo.descricao = "Premium Pass"
        tipo.identificador = "5;25;4"
        arrTipos.addObject(tipo)
        tipo = Tipo()
        tipo.descricao = "Combustível Pass"
        tipo.identificador = "5;30;4"
        arrTipos.addObject(tipo)
        tipo = Tipo()
        tipo.descricao = "Alimentação Pass"
        tipo.identificador = "5;026;4"
        arrTipos.addObject(tipo)
        tipo = Tipo()
        tipo.descricao = "Vale-Cultura da Sodexo"
        tipo.identificador = "5;27;4"
        arrTipos.addObject(tipo)
        
        return arrTipos
    }
    
    class func tituloPorIdentificador(identificador: String) -> String {
        var arrTipos = self.listaTodos()
        var predicate = NSPredicate(format: "self.identificador == %@", identificador)
        var arrFiltrado = arrTipos.filteredArrayUsingPredicate(predicate) as NSArray
        
        return arrFiltrado.objectAtIndex(0).descricao
    }
}
