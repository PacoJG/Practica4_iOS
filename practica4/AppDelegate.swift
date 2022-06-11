//
//  AppDelegate.swift
//  practica4
//
//  Created by Francisco Jaime on 06/04/22.
//

import UIKit
import CoreData
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let ud = UserDefaults.standard
        let bandera = (ud.value(forKey: "infoOk") as? Bool) ?? false
        if !bandera {
            obtenerDrinks()
        }
        // Override point for customization after application launch.
        
        return true
    }
    
    func obtenerDrinks(){
        if let rutaAlArchivo = Bundle.main.url(forResource: "Drinks", withExtension: "plist"){
            do {
                let bytes = try Data(contentsOf: rutaAlArchivo)
                let tmp = try PropertyListSerialization.propertyList(from: bytes, options: .mutableContainers, format:nil) as! [[String:String]]
                llenaBD(tmp)
                let ud = UserDefaults.standard
                ud.set(true, forKey: "infoOK")
                ud.synchronize()
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func llenaBD(_ arreglo:[[String:String]]){
        //requqerimo la descripcion de la entidad para crear objetos CD
        guard let entidad = NSEntityDescription.entity(forEntityName: "DrinksBD", in: persistentContainer.viewContext)
        else{
            return
        }
        for drink in arreglo {
            //1.- Crear un objeto bebida
            let objectdrink = NSManagedObject(entity: entidad, insertInto: persistentContainer.viewContext) as! DrinksBD
            //2.- Setear las properties del objeto, con los datos del dict
            objectdrink.inicializaCon(drink)
            //3.- salvar el objeto
            saveContext()
        }
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "practica4")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    
    
    func addDrink(_ drink: [String:String]){
        guard let entidad = NSEntityDescription.entity(forEntityName: "DrinksBD", in: persistentContainer.viewContext)
        else {
            return
        }
        print(drink)
        let objectdrink = NSManagedObject(entity: entidad, insertInto: persistentContainer.viewContext) as! DrinksBD
        objectdrink.inicializaCon(drink)
        saveContext()
        
    }
    
    
    //Fetch Request
    func consultaBD() -> [DrinksBD]{
        var resultset = [DrinksBD]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DrinksBD")
        do{
            let tmp = try persistentContainer.viewContext.fetch(request)
            resultset = tmp as! [DrinksBD]
            
        }
        catch{
            print("Fallo el request \(error.localizedDescription)")
        }
        return resultset
    }

    

}

