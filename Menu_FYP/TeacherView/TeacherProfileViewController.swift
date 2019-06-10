//
//  TeacherProfileViewController.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 02/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class TeacherProfileViewController: UIViewController {

    @IBOutlet weak var backgroundPic: UIImageView!
    @IBOutlet weak var teacherRegno: UITextView!
    @IBOutlet weak var teacherName: UITextView!
    @IBOutlet weak var showStudentButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    var teacher: User?
    let impact = UIImpactFeedbackGenerator()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Profile"
        teacherName.text = teacher?.name
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9242517352, green: 0.9300937653, blue: 0.9034610391, alpha: 1)
//        backgroundImage.image = self.blurImage(image: backgroundImage.image!)
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo",size: 21)!]
        self.makeBorder(button: showStudentButton)
        self.makeBorder(button: logOutButton)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showStudents(_ sender: Any) {
        self.impact.impactOccurred()
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ClassStudents") as! MyStudentsViewController
        destinationVC.teacher = teacher
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func blurImage(image:UIImage) -> UIImage? {
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: image)
        let originalOrientation = image.imageOrientation
        let originalScale = image.scale
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(10.0, forKey: kCIInputRadiusKey)
        let outputImage = filter?.outputImage
        
        var cgImage:CGImage?
        
        if let asd = outputImage
        {
            cgImage = context.createCGImage(asd, from: (inputImage?.extent)!)
        }
        
        if let cgImageA = cgImage
        {
            return UIImage(cgImage: cgImageA, scale: originalScale, orientation: originalOrientation)
        }
        
        return nil
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        self.impact.impactOccurred()
        dismiss(animated: true, completion: nil)
    }
    
    func makeBorder(button: UIButton)
    {
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }

}
