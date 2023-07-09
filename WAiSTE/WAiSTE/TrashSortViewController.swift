//
//  TrashSortViewController.swift
//  WAiSTE
//
//  Created by Airei Fukuzawa on 7/8/23.
//

import UIKit

class TrashSortViewController : UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func chooseImageAction(_ sender: Any) {
        showImagePickerOptions()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    

    // Create a function that returns an image picker while specifying the source type.
    // The source type tells the
    
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    func showImagePickerOptions() {
        let alertVC = UIAlertController(title: "Pick a Photo", message: "Choose a picture from Library or camera", preferredStyle: .actionSheet)
        
        // Image picker for camera
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {
            [weak self] (action) in
            // Capture self to avoid retain cycles
            guard let self = self else {
                return
            }
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            self.present(cameraImagePicker, animated: true) {
                // TODO
            }
        }
        
        // Image Picker for Library
        let libraryAction = UIAlertAction(title: "Library", style: .default) {
            [weak self] (action) in
            // Capture self to avoid retain cycles
            guard let self = self else {
                return
            }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            libraryImagePicker.delegate = self
            self.present(libraryImagePicker, animated: true) {
                // TODO
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cameraAction)
        alertVC.addAction(libraryAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC,animated: true, completion: nil)
        
    }
    
}


extension TrashSortViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as! UIImage
        self.imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
}
