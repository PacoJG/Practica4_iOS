//
//  AddDrinkViewController.swift
//  practica4
//
//  Created by Francisco Jaime on 11/06/22.
//

import UIKit
import AVFoundation

class AddDrinkViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var datosadd = DrinksBD()
    @IBOutlet weak var tv_namedrink: UITextField!
    @IBOutlet weak var tv_ingredientsdrink: UITextView!
    @IBOutlet weak var tv_instructionsdrink: UITextView!
    @IBOutlet weak var image: UIImageView!
    var rutaImage: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        var tmp = [String:String]()
        tmp["name"] = tv_namedrink.text
        tmp["ingredients"] = tv_ingredientsdrink.text
        tmp["directions"] = tv_instructionsdrink.text
        tmp["image"] = rutaImage
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.addDrink(tmp)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnFoto(_ sender: Any) {
        let ipc = UIImagePickerController()
        //ipc.sourceType = .photoLibrary
        ipc.delegate = self
        // permitir edición
        ipc.allowsEditing = true
        // consultamos si la cámara esta disponible
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // Se requiere la llave Privacy - Camer Usage Description en el archivo info.plist
            ipc.sourceType = .camera
            // Validar permiso de uso de la cámara
            let permisos = AVCaptureDevice.authorizationStatus(for: .video)
            if permisos == .authorized {
                self.present(ipc, animated: true,  completion: nil)
            }
            else {
                if permisos == .notDetermined {
                    AVCaptureDevice.requestAccess(for: .video) { respuesta in
                        if respuesta {
                            self.present(ipc, animated: true,  completion: nil)
                        }
                        else {
                            print ("¿what can i do?")
                        }
                    }
                }
                else {  // denegado
                    let alert = UIAlertController(title: "Error", message: "Debe autorizar el uso de la cámara desde el app de configuración. Quieres hacerlo ahora?", preferredStyle:.alert)
                    let btnSI = UIAlertAction(title: "Si, por favor", style: .default) { action in
                        // lanzar el app de settings:
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                    alert.addAction(btnSI)
                    alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        else {
            ipc.sourceType = .photoLibrary
            self.present(ipc, animated: true,  completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print ("seleccionó")
        if let imagen = info[.editedImage] as? UIImage {
            // Cambiar la resolución de la imagen
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 100), true, 0.75)
            imagen.draw(in: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
            let nuevaImagen = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            image.frame.size.width = 100
            image.frame.size.height = 100
            image.image = nuevaImagen
            
            self.rutaImage = (info[.imageURL] as? String)
            
            if picker.sourceType == .camera {

                MiAlbum.instance.guardar(imagen)
            }
        }
        picker.dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print ("Se cancela")
        picker.dismiss(animated: true, completion: nil)
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

