//
//  ScanQRVC.swift
//  ManageStaff
//
//  Created by administrator on 11/28/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import AVFoundation

protocol scanQRCodeDelegate {
    func sendQRCode(qrcode: String)
}
class ScanQRVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var video = AVCaptureVideoPreviewLayer()
    var session = AVCaptureSession()
    var delegate:scanQRCodeDelegate?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup for scan frame
        
        let captureDevice = AVCaptureDevice.default(for: .video)!
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
            
        }catch{
             print("Error")
        }
        let captureMetadataOutput = AVCaptureMetadataOutput()
        session.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        session.stopRunning()
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
       
        session.stopRunning()
        if let metadataObject = metadataObjects.first{
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {return}
            guard let stringValue = readableObject.stringValue else {return}
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            //CheckInVC.textfiledQRCode.text = stringValue
            self.delegate?.sendQRCode(qrcode: stringValue)
            self.dismiss(animated: false, completion: nil)
            self.dismiss(animated: false, completion: nil)
        }
        //dismiss(animated: false, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (session.isRunning == false) {
            session.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (session.isRunning == true) {
            session.stopRunning()
        }
    }
    
    

}
