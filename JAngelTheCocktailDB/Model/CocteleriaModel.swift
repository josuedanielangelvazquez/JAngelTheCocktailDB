//
//  CocteleriaModel.swift
//  JAngelTheCocktailDB
//
//  Created by MacBookMBA6 on 08/03/23.
//

import Foundation

import Foundation

struct CoctelsDrinks : Codable{
    let drinks : [drinks]?
}
struct drinks : Codable{
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
}

class Cocteleria{
    func getbyname(name : String, ObjectDrinks : @escaping(CoctelsDrinks?)->Void){
        let urlsession = URLSession.shared
        let url = URL(string:"https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(name)")
        urlsession.dataTask(with: url!){
            data, response, error in
            if let safedata = data{
                let json = self.parsejson(data: safedata)
                ObjectDrinks(json)
            }
            else{(print("Error al recivir la informacion \(error?.localizedDescription)"))}
        }.resume()
        
    }
    func getbyletter(name : String, ObjectDrinks: @escaping(CoctelsDrinks)->Void){
        let urlsession = URLSession.shared
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=\(name)")
        urlsession.dataTask(with: url!){data, response, error in
            if let safedata = data{
                let json = self.parsejson(data: data!)
                ObjectDrinks(json!)
            }
        }.resume()
    }
    func getdetailbyid(IdDrink : String, ObjectDrink: @escaping(CoctelsDrinks)->Void){
        let urlsession = URLSession.shared
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(IdDrink)")
        urlsession.dataTask(with: url!){data, response, error in
            if let safedata = data{
                let json = self.parsejson(data: data!)
                ObjectDrink(json!)
            }
        }.resume()
    }
    
    func parsejson(data: Data)->CoctelsDrinks?{
        let decodable = JSONDecoder()
        do{
            let request = try! decodable.decode(CoctelsDrinks.self, from: data)
            let drinks = CoctelsDrinks(drinks: request.drinks)
            
            return drinks
        }
        catch let error{
            print("error en el decoder \(error.localizedDescription)")
            return nil
        }
    }
}
