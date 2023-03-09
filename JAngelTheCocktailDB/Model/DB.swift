//
//  DB.swift
//  JAngelTheCocktailDB
//
//  Created by MacBookMBA6 on 08/03/23.
//

import Foundation
import SQLite3
    
class DB{
    let path : String = "Document.JAngelTheCocktailDB"
    var db : OpaquePointer? = nil
    
    init(){
        db = OpenConexion()
    }
    func OpenConexion()->OpaquePointer?{
        let filepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension(self.path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filepath.path, &db) == SQLITE_OK
        {
            print("Conexion Correcta")
            print(filepath)
            return db
        }
        else{
            print("Error")
            return nil
        }
    }
}

class CoctelFav{
    let ModelDirnks : drinks? = nil
    func add(drink : drinks)->Bool {
        var correct = false
        let context = DB.init()
        let query = "Insert INTO Favoritos(idcoctelfavorito, namecoctel, imagelink) VALUES(?,?,?)"
        var statement: OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                sqlite3_bind_text(statement, 1, (drink.idDrink as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 2, (drink.strDrink as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 3, (drink.strDrinkThumb as NSString).utf8String, -1, nil)
                if sqlite3_step(statement) == SQLITE_DONE{
                    correct = true
                }
                else{
                    correct = false
                }
            }
        }
        catch let error{
            print("Error al registrar")
            print(error.localizedDescription)
        }
        return correct
    }
    
    func Getall()->[drinks]{
        var OBjectDrinks = [drinks]()
        let context = DB.init()
        let query = "SELECT idcoctelfavorito, namecoctel, imagelink FROM Favoritos"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                
                
                while sqlite3_step(statement) == SQLITE_ROW{
                    var drink = drinks(idDrink: "", strDrink: "", strDrinkThumb: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "")
                    
                    drink.idDrink = String(cString: sqlite3_column_text(statement, 0))
                    drink.strDrink = String(cString: sqlite3_column_text(statement, 1))
                    drink.strDrinkThumb = String(cString: sqlite3_column_text(statement, 2))
                    OBjectDrinks.append(drink)
                }
                
            }
        }
        catch let error{
            print("Error al recuperar los datos")
            print(error.localizedDescription)
        }
        return OBjectDrinks

    }

}
    
    
    

