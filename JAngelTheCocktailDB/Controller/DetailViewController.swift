//
//  DetailViewController.swift
//  JAngelTheCocktailDB
//
//  Created by MacBookMBA6 on 08/03/23.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let detailcoctel = Cocteleria()
    var idDrink = ""
    var Coctels = [drinks]()
    var Ingredientes = [String]()
    
    @IBOutlet weak var DrinkImage: UIImageView!
    
    @IBOutlet weak var IngredientesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        IngredientesCollectionView.delegate = self
        IngredientesCollectionView.dataSource = self
        view.addSubview(IngredientesCollectionView)
        
        self.IngredientesCollectionView.register(UINib(nibName: "CoctelesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "coctelesCell")
        loadData()

    }
    func loadData(){
        detailcoctel.getdetailbyid(IdDrink: idDrink) { [self] ObjectCoctel in
            DispatchQueue.main.async { [self] in
                self.Coctels = ObjectCoctel.drinks as! [drinks]
               title  = Coctels[0].strDrink
                if Coctels[0].strIngredient1 != nil{
                    Ingredientes.append(Coctels[0].strIngredient1!)}
                if Coctels[0].strIngredient2 != nil{
                   Ingredientes.append(Coctels[0].strIngredient2!)}
                if Coctels[0].strIngredient3 != nil{
                    Ingredientes.append(Coctels[0].strIngredient3!)}
                if Coctels[0].strIngredient4 != nil{
                    Ingredientes.append(Coctels[0].strIngredient4!)}
                if Coctels[0].strIngredient5 != nil{
                    Ingredientes.append(Coctels[0].strIngredient5!)}
                if Coctels[0].strIngredient6 != nil{
                    Ingredientes.append(Coctels[0].strIngredient6!)}
                if Coctels[0].strIngredient7 != nil{
                    Ingredientes.append(Coctels[0].strIngredient7!)}
                if Coctels[0].strIngredient8 != nil{
                    Ingredientes.append(Coctels[0].strIngredient8!)}
                if Coctels[0].strIngredient9 != nil{
                    Ingredientes.append(Coctels[0].strIngredient9!)}
                if Coctels[0].strIngredient10 != nil{
                    Ingredientes.append(Coctels[0].strIngredient10!)}
                if Coctels[0].strIngredient11 != nil{
                    Ingredientes.append(Coctels[0].strIngredient11!)}
                if Coctels[0].strIngredient12 != nil{
                    Ingredientes.append(Coctels[0].strIngredient12!)}
                if Coctels[0].strIngredient13 != nil{
                    Ingredientes.append(Coctels[0].strIngredient13!)}
                if Coctels[0].strIngredient14 != nil{
                    Ingredientes.append(Coctels[0].strIngredient14!)}
                if Coctels[0].strIngredient15 != nil{
                    Ingredientes.append(Coctels[0].strIngredient15!)}
            
                let url = URL(string: Coctels[0].strDrinkThumb)
                if let data = try? Data(contentsOf: url!){
                    DrinkImage.image = UIImage(data: data)}
                
                self.IngredientesCollectionView.reloadData()
            }
           
         
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Ingredientes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coctelesCell", for: indexPath as IndexPath) as! CoctelesCollectionViewCell
        cell.progressload.isHidden = false
        cell.progressload.startAnimating()
        cell.namelbl.text = Ingredientes[indexPath.row]
        var name = Ingredientes[indexPath.row].replacingOccurrences(of: " ", with: "%20")
        print("provando\(name)verificando")
        let url = URL(string: "https://www.thecocktaildb.com/images/ingredients/\(name).png")
        print(url)
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url!){
                cell.CoctelImage.image = UIImage(data: data)
                cell.progressload.isHidden = true
                cell.progressload.stopAnimating()
            }
        }
        
        return cell
        		
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
