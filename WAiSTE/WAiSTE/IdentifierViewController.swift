//
//  IdentifierViewController.swift
//  WAiSTE
//
//  Created by Airei Fukuzawa on 7/8/23.
//

import UIKit
import Vision
import OpenAI

import Starscream

class IdentifierViewController : UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var classifier = Classifier()
    var isConnected = false
    var socket = WebSocket(request: URLRequest(url: URL(string: "http://localhost:8080")!))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var objectName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // Create a function that returns an image picker while specifying the source type.
    // The source type tells the
    @IBAction func chooseImageAction(_ sender: Any) {
        showImagePickerOptions()
        
        
//        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        
        
    }
    
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
    
    func identifyObject () {
        guard let uiImage = imageView.image else {
            return
        }
        guard let ciImage = CIImage(image: uiImage) else {
            return
        }
        
        classifier.detect(ciImage: ciImage)
        if classifier.results == nil {
            DispatchQueue.main.async{
                self.objectName.text = "Error!"
            }
            
        }else {
            DispatchQueue.main.async{
                self.objectName.text = self.classifier.results
            }
            
        }
    }
    
}


extension IdentifierViewController: WebSocketDelegate {
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                isConnected = false
            case .error(let error):
                isConnected = false
                print(error ?? "Error")
            }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as! UIImage
        self.imageView.image = image
        
        
        guard let ciImage = CIImage(image: image) else {
            return
        }
        
        classifier.detect(ciImage: ciImage)
        if classifier.results == nil {
            DispatchQueue.main.async{
                self.objectName.text = "Error!"
            }
            
        }else {
            DispatchQueue.main.async{
                self.objectName.text = self.classifier.results
            }
            
        }
        
        var request = URLRequest(url: URL(string: "http://localhost:8080")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        
//        let query = CompletionsQuery(model: .textDavinci_003, prompt: "What is 42?", temperature: 0, maxTokens: 100, topP: 1, frequencyPenalty: 0, presencePenalty: 0, stop: ["\\n"], user: <#String?#>)
//        OpenAI.completions(query: query) { result in
//          //Handle result here
//        }
//        //or
//        let result = try await openAI.completions(query: query)
        self.dismiss(animated: true, completion: nil)
    }
   
}
