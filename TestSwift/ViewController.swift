//
//  ViewController.swift
//  TestSwift
//
//  Created by Blaz Oblak on 9/8/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, WSDelegate {
    
    
    
    enum BtnAction: Int {
        case like = 1
        case coment = 2
        case share = 3
    }
    
    enum TableTAG: Int {
        case tagImage = 10
        case tagLabel = 11
        case tagLabelComent = 12
        case tagFilterName = 13
    }
    
    var theScrollView: UIScrollView?
    var userPostsArr: [UserData]?
    var theTableview: UITableView?
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    let ROW_HEIGHT: CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        screenWidth = self.view.frame.size.width
        screenHeight = self.view.frame.size.height
        let toolbarHeight: CGFloat = 70
        
        self.view.backgroundColor = UIColor.black
        
        theScrollView = UIScrollView()
        theScrollView?.frame = CGRect(x: 0, y: toolbarHeight, width: screenWidth, height: screenHeight - toolbarHeight)
        theScrollView?.contentSize = CGSize(width: screenWidth, height: screenHeight + 100)
        theScrollView?.backgroundColor = UIColor.black
        self.view.addSubview(theScrollView!)
        
        
        
        
        let viewToolbar = UIView()
        viewToolbar.frame = CGRect(x: 0, y: 0, width: screenWidth, height: toolbarHeight)
        self.view.addSubview(viewToolbar)
        
        let viewLine = UIView()
        viewLine.frame = CGRect(x: 0, y: toolbarHeight-1, width: screenWidth, height: 1)
        viewLine.backgroundColor = UIColor.white
        viewToolbar.addSubview(viewLine)
        
        
        let labelTitle = UILabel()
        labelTitle.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 40)
        labelTitle.text = "Instagram"
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.white
        viewToolbar.addSubview(labelTitle)
        
        let btnDimen = 30
        let btnPhoto = UIButton()
        btnPhoto.frame = CGRect(x: 10, y: Int(toolbarHeight)/2 - btnDimen/2, width: btnDimen, height: btnDimen)
        btnPhoto.backgroundColor = UIColor.red
        btnPhoto.addTarget(self, action: #selector(didPressBtnPhoto), for: .touchUpInside)
        viewToolbar.addSubview(btnPhoto)
        
        let btnArrow = UIButton()
        btnArrow.frame = CGRect(x: Int(screenWidth) - btnDimen - 10, y: Int(toolbarHeight)/2 - btnDimen/2, width: btnDimen, height: btnDimen)
        btnArrow.backgroundColor = .green
        btnArrow.addTarget(self, action: #selector(didPressBtnArrow), for: .touchUpInside)
        viewToolbar.addSubview(btnArrow)
        
        
        //Scale Image
        let imageUser = UIImage(named: "car.jpg")
        //let scale = (imageUser?.size.width)! / screenWidth
        let scale = screenWidth / (imageUser?.size.width)!
        
        
        var contentY: Int = 0
        
        userPostsArr = []
        
        let comentArr: [String] = ["Danes je lep dan", "burek je hrana", "neki pišem", "Babe so krneki", "Rabim pivo"]
        
        for i in 0 ..< 100 {
            
            let user = UserData()
            user.name = "Vesna Žorž \(i)"
            
            for i in 0..<comentArr.count {
                user.comentArr.append(comentArr[i])
            }
            
            userPostsArr?.append(user)
            
        }
        
        //Add filters
        //let filterNames: [String] = ["CIPhotoEffectTonal","CIPhotoEffectNoir","CIMaximumComponent","CIMinimumComponent","CIDotScreen", "CISepiaTone", "CIFalseColor", "CIColorInvert", "CIColorPosterize", "CIPhotoEffectChrome", "CIPhotoEffectInstant"]
        
        let filterNames = ["CIBumpDistortion", "CIGaussianBlur", "CIPixellate", "CISepiaTone", "CITwirlDistortion", "CIUnsharpMask", "CIVignette", "CIEdges"]
        
        var index: Int = 0
        for el in userPostsArr!{
            
            el.filterName = filterNames[index]
            if index+1 < filterNames.count{
                index+=1
            }else{
                index=0
            }
            
            
        }
        
        for i in 0..<3 {
            
            //let userData = UserData()
            //userData.name = "Blaz oblak \(i)"
            //userData.imgName = ""
            
            let userData = userPostsArr?[i]
            
            let labelUsername = UILabel()
            labelUsername.frame = CGRect(x: 10, y: contentY, width: Int(screenWidth)-10, height: 20)
            labelUsername.text = userData?.name
            labelUsername.textColor = .white
            theScrollView?.addSubview(labelUsername)
            
            let imgUser = UIImageView()
            imgUser.frame = CGRect(x: 0, y: labelUsername.frame.origin.y + labelUsername.frame.size.height, width: screenWidth, height: (imageUser?.size.height)! * scale);
            imgUser.image = UIImage(named: "car.jpg")
            imgUser.backgroundColor = .red
            theScrollView?.addSubview(imgUser)
            
            let btnActionDimen = 25.0
            let btnY = imgUser.frame.origin.y + imgUser.frame.size.height
            let btnLike = UIButton()
            btnLike.frame = CGRect(x: 10, y: Double(btnY), width: btnActionDimen, height: btnActionDimen)
            btnLike.backgroundColor = UIColor.green
            btnLike.tag = BtnAction.like.rawValue
            btnLike.addTarget(self, action: #selector(didPressBtnAction(sender:)), for: UIControl.Event.touchUpInside)
            theScrollView?.addSubview(btnLike)
            
            let btnComent = UIButton()
            btnComent.frame = CGRect(x: Double(btnLike.frame.origin.x + btnLike.frame.size.width + 10), y: Double(btnY), width: btnActionDimen, height: btnActionDimen)
            btnComent.backgroundColor = UIColor.green
            btnComent.tag = BtnAction.coment.rawValue
            btnComent.addTarget(self, action: #selector(didPressBtnAction(sender:)), for: UIControl.Event.touchUpInside)
            theScrollView?.addSubview(btnComent)
            
            let btnShare = UIButton()
            btnShare.frame = CGRect(x: Double(btnComent.frame.origin.x + btnComent.frame.size.width + 10), y: Double(btnY), width: btnActionDimen, height: btnActionDimen)
            btnShare.backgroundColor = UIColor.green
            btnShare.tag = BtnAction.share.rawValue
            btnShare.addTarget(self, action: #selector(didPressBtnAction(sender:)), for: UIControl.Event.touchUpInside)
            theScrollView?.addSubview(btnShare)
            
            contentY = Int(btnLike.frame.origin.y + btnLike.frame.size.height)
            
        }
        
        theScrollView?.contentSize = CGSize(width: Int(screenWidth), height: contentY)
        
        let del = UIView()
        del.frame = CGRect(x: 0, y: contentY, width: 50, height: 50)
        del.backgroundColor = UIColor.red
        theScrollView?.addSubview(del)
        theScrollView?.isHidden = true
        
        let frame = CGRect(x: 0, y: toolbarHeight, width: screenWidth, height: screenHeight - toolbarHeight)
        theTableview = UITableView(frame: frame, style: UITableView.Style.plain)
        theTableview?.delegate = self
        theTableview?.dataSource = self
        //theTableview?.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(theTableview!)
        
    }

    @objc func didPressBtnPhoto() -> () {
        print("didPressBtnPhoto :)")
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true)
            
        }else{
            
            print("ne mores slikati")
            
        }
        
    }
    
    @objc func didPressBtnArrow() -> (){
        print("didPressBtnArrow")
        
        let ws = WS()
        ws.delegate = self
        ws.getDataFromServer()
        
    }
    
    @objc func didPressBtnAction(sender: UIButton){
        print("didPressBtnAction \(sender.tag)")
    }
    
    // MARK: WSDelegate
    func getDataFinished(status: Int, response: String) {
        print("getDataFinished status\(status) response:\(response)")
    }
    
    // MARK: UITableviewDelegat
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let nOfRows = userPostsArr?.count {
            return nOfRows
        }else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifire: String = "Cell"
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifire)
        
        var imgUser: UIImageView
        var labelUsername: UILabel
        var labelComent: UILabel
        var labelFilterName: UILabel
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifire)
            
            imgUser = UIImageView.init(frame: CGRect(x: 0, y: 0, width: ROW_HEIGHT, height: ROW_HEIGHT))
            imgUser.backgroundColor = UIColor.red
            imgUser.tag = TableTAG.tagImage.rawValue
            cell?.contentView.addSubview(imgUser)
            
            labelUsername = UILabel.init()
            labelUsername.frame = CGRect(x: imgUser.frame.origin.x + imgUser.frame.size.width + 10, y: 5, width: screenWidth - imgUser.frame.size.width - 20, height: 20)
            labelUsername.backgroundColor = .green
            labelUsername.tag = TableTAG.tagLabel.rawValue
            cell?.contentView.addSubview(labelUsername)
            
            labelComent = UILabel()
            labelComent.frame = CGRect(x: labelUsername.frame.origin.x, y: labelUsername.frame.origin.y + labelUsername.frame.size.height + 5, width: labelUsername.frame.size.width, height: 17)
            labelComent.backgroundColor = .green
            labelComent.textColor = UIColor.gray
            labelComent.font = UIFont.systemFont(ofSize: 12)
            labelComent.tag = TableTAG.tagLabelComent.rawValue
            cell?.contentView.addSubview(labelComent)
            
            labelFilterName = UILabel()
            labelFilterName.frame = CGRect(x: labelUsername.frame.origin.x, y: labelComent.frame.origin.y + labelComent.frame.size.height, width: labelComent.frame.size.width, height: 17)
            labelFilterName.textColor = .brown
            labelFilterName.font = UIFont.systemFont(ofSize: 12)
            labelFilterName.tag = TableTAG.tagFilterName.rawValue
            cell?.contentView.addSubview(labelFilterName)
            
        }else{
            
            imgUser = cell?.viewWithTag(TableTAG.tagImage.rawValue) as! UIImageView
            labelUsername = cell?.viewWithTag(TableTAG.tagLabel.rawValue) as! UILabel
            labelComent = cell?.viewWithTag(TableTAG.tagLabelComent.rawValue) as! UILabel
            labelFilterName = cell?.viewWithTag(TableTAG.tagFilterName.rawValue) as! UILabel
            
        }
        
        imgUser.image = UIImage(named: "car.jpg")
        
        let el = userPostsArr![indexPath.row]
        
        let comment = el.comentArr[(indexPath.row % el.comentArr.count)]
        
        labelUsername.text = el.name
        labelComent.text = comment
        labelFilterName.text = el.filterName
        
        ///transformImage(imgProfile: imgUser, filterName: "")
        
        //cell?.textLabel?.text = el.name
        
        return cell!
        
    }
    
    // TODO: Test
    
    // FIXME: popravi me
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ROW_HEIGHT
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let el = userPostsArr?[indexPath.row]
        if let name = el?.name {
            print(name)
            
            //let vc = DetailViewController()
            
            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            //vc2.modalPresentationStyle = .fullScreen
            //vc2.labelFilterName.text = el?.filterName!
            //_ = vc2.view
            vc2.labelData = el?.filterName
            
            present(vc2, animated: true)
            
        }else{
            print("Ni elementa ;)")
        }
        
    }
    
    // MARK: UIImagePickerControllerDelegat
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        print(image.size)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helper
    
    func transformImage(imgProfile: UIImageView?, filterName: String) -> () {
        
        let inputImage = UIImage(named: "car.jpg")
        let context = CIContext(options: nil)
        
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
    
}

