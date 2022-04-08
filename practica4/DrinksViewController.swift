//
//  TableViewController.swift
//  practica3
//
//  Created by Francisco Jaime on 28/03/22.
//

import UIKit
import CoreData

class DrinksViewController: UIViewController, UITableViewDelegate,UITableViewDataSource  {
    
    var datos = [DrinksBD]()
    var datosadd = DrinksBD()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tv_namedrink: UITextView!
    @IBOutlet weak var tv_ingredientsdrink: UITextView!
    @IBOutlet weak var tv_instructionsdrink: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    /*override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemGray
        //obtenInfo()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDel = UIApplication.shared.delegate as! AppDelegate
        datos = appDel.consultaBD()
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datos.count
    }
    
    /*func obtenInfo(){
        //encuentra la ubicacion en tiempo de ejecucion de un archivo agregado al proyecto
        if let rutaAlArchivo = Bundle.main.url(forResource: "Drinks", withExtension: "plist"){
            do {
                let bytes = try Data.init(contentsOf: rutaAlArchivo)
                let tmp = try PropertyListSerialization.propertyList(from: bytes, options: .mutableContainers, format: nil)
                datos = tmp as! [[String:Any]]
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }*/


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewdrinks", for: indexPath)
        let elDrink = datos[indexPath.row]
        //let drinkName = (elDict["name"] as? String) ?? "\(indexPath)"
        let tmpimage = (elDrink.image) ?? ""
        let imageDrink = UIImage(named:(tmpimage.lowercased())) ?? UIImage()
        
        cell.textLabel?.text = elDrink.name
        cell.imageView?.image = imageDrink
        cell.imageView?.image = imageDrink.resize(60, 60)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detalle", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
         let nuevoVC = segue.destination as! ViewController
       // Pass the selected object to the new view controller.
         if let indexPath = tableView.indexPathForSelectedRow {
             let elDrink = datos[indexPath.row]
             nuevoVC.detalle_drink = elDrink
             tableView.deselectRow(at: indexPath, animated: true)
         }
    }
    
    @IBAction func updateTable(_ sender: Any) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        datos = appDel.consultaBD()
        self.tableView.reloadData()
    }
    
    @IBAction func onClickAdd(_ sender: Any) {
        var newDrink = [String:String]()
        let appDel = UIApplication.shared.delegate as! AppDelegate
        //let newDrink = DrinksBD(context: self.context)
        newDrink["name"] = tv_namedrink.text
        newDrink["ingredients"] = tv_ingredientsdrink.text
        newDrink["directions"] = tv_instructionsdrink.text
        newDrink["image"] = "0.jpg"
        appDel.addDrink(newDrink)
        self.dismiss(animated: true, completion: nil)
        //appDel.consultaBD()
    }
    
}

extension UIImage {
    func resize(_ width: CGFloat, _ height:CGFloat) -> UIImage? {
        let widthRatio  = width / size.width
        let heightRatio = height / size.height
        let ratio = widthRatio > heightRatio ? heightRatio : widthRatio
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
