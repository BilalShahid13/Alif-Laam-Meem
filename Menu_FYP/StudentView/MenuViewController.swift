//
//  MenuViewController.swift
//  Menu_FYP
//
//  Created by Bilal Shahid on 11/8/18.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController{
    var Student: User?
    @IBOutlet weak var quranButton: UIButton!
    @IBOutlet weak var qaidaButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    let impact = UIImpactFeedbackGenerator()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeBorder(button: quranButton)
        self.makeBorder(button: qaidaButton)
        self.makeBorder(button: logOutButton)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9242517352, green: 0.9300937653, blue: 0.9034610391, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
//        backgroundImage.image = self.blurImage(image: backgroundImage.image!)
        self.title = "Dashboard"
        navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo",size: 21)!]
    }
    @IBAction func segueQaida(_ sender: Any) {
        self.impact.impactOccurred()
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "QaidaMain") as! QaidaViewController
        destinationVC.student = self.Student
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        self.impact.impactOccurred()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segueQuran(_ sender: Any) {
        self.impact.impactOccurred()
        self.performSegue(withIdentifier: "DashboardToSurahs", sender: nil)
    }

    func makeBorder(button: UIButton)
    {
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
