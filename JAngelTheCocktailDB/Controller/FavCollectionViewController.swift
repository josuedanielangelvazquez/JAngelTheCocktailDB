//
//  FavCollectionViewController.swift
//  JAngelTheCocktailDB
//
//  Created by MacBookMBA6 on 08/03/23.
//

import UIKit

private let reuseIdentifier = "Cell"
var coctelsfavs = [drinks]()
let favcoctels = CoctelFav()
var idDrink = ""

class FavCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "CoctelesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "coctelesCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    func loadData(){
       coctelsfavs = favcoctels.Getall() as! [drinks]
        collectionView.reloadData()
        
    }
    func seugesDetail(){
        
    }
    func deletedata(idDrink : String){
        if favcoctels.delete(IdDrink: idDrink) == true{
            viewWillAppear(true)
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Ocurrio un Error, intentalo mas tarde", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return coctelsfavs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coctelesCell", for: indexPath as IndexPath) as! CoctelesCollectionViewCell
        cell.progressload.isHidden = false
        cell.progressload.startAnimating()
        cell.namelbl.text = coctelsfavs[indexPath.row].strDrink
        
        let url = URL(string: coctelsfavs[indexPath.row].strDrinkThumb)
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url!){
                cell.CoctelImage.image = UIImage(data: data)
                cell.progressload.isHidden = true
                cell.progressload.stopAnimating()
            }
        }
    
        // Configure the cell
    
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "¿Que deseas hacer?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Detalles", style: .default){action in
            idDrink = coctelsfavs[indexPath.row].idDrink
            self.performSegue(withIdentifier: "seguesdetailpersistence", sender: nil)
            
        })
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive){
            action in
            self.deletedata(idDrink: coctelsfavs[indexPath.row].idDrink)
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alert, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguesdetailpersistence"{
            let detail = segue.destination as! DetailViewController
            detail.idDrink = idDrink
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
