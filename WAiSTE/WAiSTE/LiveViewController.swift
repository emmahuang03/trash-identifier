//
//  LiveViewController.swift
//  WAiSTE
//
//  Created by Airei Fukuzawa on 7/8/23.
//

import UIKit
import AVKit
import Vision

class LiveViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start up the camera
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
//        let request = VNCoreMLRequest(model: <#T##VNCoreMLModel#>)
//        VNImageRequestHandler(cgImage: <#T##CGImage#>)
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutputsampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("Camera was able to capture a frame:", Date())
        
//        CMSampleBufferGetImageBuffer(sampleBuffer)
//        VNImageRequestHandler(cvPixelBuffer: <#T##CVPixelBuffer#>)
    }
}
