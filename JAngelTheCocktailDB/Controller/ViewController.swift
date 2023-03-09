//
//  ViewController.swift
//  JAngelTheCocktailDB
//
//  Created by MacBookMBA6 on 08/03/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var cocteleria = Cocteleria()
    var coctelesdrinks = [drinks]()
    var DrinkId =  ""
    @IBOutlet weak var searchtext: UITextField!
    
    
    @IBOutlet weak var CoctelesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        CoctelesCollectionView.delegate = self
        CoctelesCollectionView.dataSource = self
        view.addSubview(CoctelesCollectionView)
        self.CoctelesCollectionView.register(UINib(nibName: "CoctelesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "coctelesCell")
    }
    func loadData(text : String){
        cocteleria.getbyname(name: text) { Objectdrinks in
            DispatchQueue.main.async {
                if Objectdrinks?.drinks == nil{
                    print("No hay bebeidas relacionadas")
                }
                else{
                    self.coctelesdrinks = Objectdrinks!.drinks as! [drinks]
                    self.CoctelesCollectionView.reloadData()
                    self.searchtext.backgroundColor = .white
                    self.searchtext.text = ""
                }
                  
            }
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coctelesdrinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CoctelesCollectionView.dequeueReusableCell(withReuseIdentifier: "coctelesCell", for: indexPath as IndexPath) as! CoctelesCollectionViewCell
        cell.progressload.isHidden = false
        cell.progressload.startAnimating()
        cell.namelbl.text = coctelesdrinks[indexPath.row].strDrink
print(coctelesdrinks[indexPath.row].strDrinkThumb)
        var url = URL(string: coctelesdrinks[indexPath.row].strDrinkThumb)
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url!){
                cell.progressload.isHidden = true
                cell.progressload.stopAnimating()
                cell.CoctelImage.image = UIImage(data: data)
                
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.DrinkId = coctelesdrinks[indexPath.row].idDrink
        performSegue(withIdentifier: "seguesdetail", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguesdetail"{
            let detail = segue.destination as! DetailViewController
            detail.idDrink = self.DrinkId
            print("valor del \(detail.idDrink)")
            
        }
    }
    
    
    @IBAction func SearchAction(_ sender: Any) {
        guard searchtext.text != ""	 else{
            searchtext.backgroundColor = .red
            searchtext.placeholder = "Ingrese una bebida"
            return
        }
        loadData(text: searchtext.text!)
      
    }
}

