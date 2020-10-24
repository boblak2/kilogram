//
//  DetailViewController.swift
//  TestSwift
//
//  Created by Blaz Oblak on 9/15/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController{
    
    
    @IBOutlet weak var labelFilterName: UILabel!
    
    var screenWidth: CGFloat?
    var screnHeight: CGFloat?
    var imgProfile: UIImageView?
    var labelData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let imgProfile = UIImage(named: "car.jpg")
        
        screenWidth = self.view.frame.size.width
        screnHeight = self.view.frame.size.height
        
        
        imgProfile = UIImageView()
        imgProfile?.frame = CGRect(x: 0, y: 0, width: screenWidth!, height: screnHeight! / 2)
        imgProfile?.backgroundColor = UIColor.red
        imgProfile?.image = UIImage(named: "v.jpg")
        imgProfile?.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.addSubview(imgProfile!)
        
        
        let btnAction = UIButton()
        btnAction.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btnAction.backgroundColor = .green
        btnAction.addTarget(self, action: #selector(didPressBtnAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btnAction)
        
        
        labelFilterName.text = labelData
        //addFilterToPhoto()
        
        /*
        let defaults: UserDefaults = UserDefaults.standard
        let age = defaults.integer(forKey: "age")
        let text = defaults.object(forKey: "burek") as? String ?? "ni shranjem"
        print("age\(age) burek:\(text)")
        */
        
    }
    
    @objc func didPressBtnAction() {
        print("didPressBtnAction")
        
        addFilterToPhoto()
        //photoEfectTransfer()
        //blackAndWhite()
        //sepiaFilter()
        
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(35, forKey: "age")
        defaults.set("blazJeCar", forKey: "burek")
        defaults.synchronize()
        
    }
    
    
    func transformImage(value: Float) -> () {
        
        let inputImage = UIImage(named: "v.jpg")
        let context = CIContext(options: nil)
        
        //CIPhotoEffectTransfer
        
        guard let imeFiltra = labelData else{
            print("imeFiltra ne obtsja")
            return
        }
        
        if let currentFilter = CIFilter(name: imeFiltra) {
            
            let beginImage = CIImage(image: inputImage!)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            
            let inputKeysArr = currentFilter.inputKeys
            print("inputKeys:\(inputKeysArr)")
            
            if inputKeysArr.contains(kCIInputIntensityKey) {
                currentFilter.setValue(value, forKey: kCIInputIntensityKey)
            }
            if inputKeysArr.contains(kCIInputIntensityKey) {
                currentFilter.setValue(value, forKey: kCIInputIntensityKey)
            }
            if inputKeysArr.contains(kCIInputRadiusKey) {
                currentFilter.setValue(value * 400, forKey: kCIInputRadiusKey)
            }
            if inputKeysArr.contains(kCIInputScaleKey) {
                currentFilter.setValue(value * 20, forKey: kCIInputScaleKey)
            }
            if inputKeysArr.contains(kCIInputCenterKey) {
                let xCenter = (inputImage?.size.width ?? 1)/2
                let yCenter = (inputImage?.size.height ?? 1)/2
                let vector: CIVector = CIVector(x: xCenter, y: yCenter)
                currentFilter.setValue(vector, forKey: kCIInputCenterKey)
            }
            
            
            let filterImageData = currentFilter.value(forKey: kCIOutputImageKey) as! CIImage
            let filterImageRef = context.createCGImage(filterImageData, from: filterImageData.extent)
            
            let originalOrientation: UIImage.Orientation = (imgProfile?.image?.imageOrientation)!
            let originalScale: CGFloat = (imgProfile?.image?.scale)!
            
            let newImage: UIImage = UIImage(cgImage: filterImageRef!, scale: originalScale, orientation: originalOrientation)
            
            imgProfile?.image = newImage
            
        }
        
    }
    
    func addFilterToPhoto() -> () {
        
        let inputImage = UIImage(named: "car.jpg")
        let context = CIContext(options: nil)
        
        //CIPhotoEffectTransfer
        
        guard let imeFiltra = labelData else{
            print("imeFiltra ne obtsja")
            return
        }
        
        if let currentFilter = CIFilter(name: imeFiltra) {
            
            let beginImage = CIImage(image: inputImage!)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            
            let filterImageData = currentFilter.value(forKey: kCIOutputImageKey) as! CIImage
            let filterImageRef = context.createCGImage(filterImageData, from: filterImageData.extent)
            
            let originalOrientation: UIImage.Orientation = (imgProfile?.image?.imageOrientation)!
            let originalScale: CGFloat = (imgProfile?.image?.scale)!
            
            let newImage: UIImage = UIImage(cgImage: filterImageRef!, scale: originalScale, orientation: originalOrientation)
            
            imgProfile?.image = newImage
            
        }
        
    }
    
    func photoEfectTransfer() -> () {
        
        let inputImage = UIImage(named: "car.jpg")
        let context = CIContext(options: nil)
        
        //CIPhotoEffectTransfer
        
        if let currentFilter = CIFilter(name: "CIPhotoEffectInstant") {
            
            let beginImage = CIImage(image: inputImage!)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            
            let filterImageData = currentFilter.value(forKey: kCIOutputImageKey) as! CIImage
            let filterImageRef = context.createCGImage(filterImageData, from: filterImageData.extent)
            
            let originalOrientation: UIImage.Orientation = (imgProfile?.image?.imageOrientation)!
            let originalScale: CGFloat = (imgProfile?.image?.scale)!
            
            let newImage: UIImage = UIImage(cgImage: filterImageRef!, scale: originalScale, orientation: originalOrientation)
            
            imgProfile?.image = newImage
            
        }
        
    }
    
    func blackAndWhite() -> () {
        
        let inputImage = UIImage(named: "car.jpg")
        let context = CIContext(options: nil)
        
        if let currentFilter = CIFilter(name: "CIPhotoEffectNoir"){
            
            let beginImage = CIImage(image: inputImage!)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent){
                    let processedImage = UIImage(cgImage: cgimg)
                    imgProfile?.image = processedImage
                }
            }
            
        }
        
    }
    
    func sepiaFilter() -> () {
        
        let inputImage = UIImage(named: "car.jpg")
        let context = CIContext(options: nil)
        
        if let currentFilter = CIFilter(name: "CISepiaTone"){
            
            let beginImage = CIImage(image: inputImage!)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(0.5, forKey: kCIInputIntensityKey)
            
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent){
                    let processedImage = UIImage(cgImage: cgimg)
                    imgProfile?.image = processedImage
                }
            }
            
        }
        
    }
    
    
    @IBAction func didSlide(_ sender: Any) {
        let tmp: UISlider = sender as! UISlider
        print(tmp.value)
        transformImage(value: tmp.value)
    }
    
}
