//
//  AddPlaceVC.swift
//  FoursquareClone
//
//  Created by mac on 6/22/23.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var placenameText: UITextField!
    @IBOutlet weak var placestyleText: UITextField!
    @IBOutlet weak var placeatmosphereText: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecgonizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecgonizer)
    }
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        if placenameText.text != "" && placestyleText.text != "" && placeatmosphereText.text != "" {
            if let choseImage = placeImageView.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placenameText.text!
                placeModel.placeType = placestyleText.text!
                placeModel.placeAtmosphere = placeatmosphereText.text!
                placeModel.placeImage = choseImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        } else {
            self.makeAlert(title: "Error", message: "Place Name/Type/Atmosphere missing")
        }
    }
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
