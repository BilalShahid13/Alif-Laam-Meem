//
//  NewAssessmentViewController.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 14/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
class NewAssessmentViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SBCardPopupContent{
    @IBOutlet weak var assessmentContentCV: UICollectionView!
    
    let reuseIdentifier="wordButton"
    //Audio variables
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var player: AVAudioPlayer?
    @IBOutlet weak var recordButtonOutlet: UIButton!
    @IBOutlet weak var playRecordingOutlet: UIButton!
    //pop up variables
    var popupViewController: SBCardPopupViewController?
    var allowsTapToDismissPopupCard: Bool = true
    var allowsSwipeToDismissPopupCard: Bool = true
    //
    @IBOutlet weak var submitButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioRecorder = nil
        recordButtonOutlet.setTitle("Record", for: .normal)
        playRecordingOutlet.isEnabled = false
        submitButtonOutlet.isEnabled = false
        getMicroPhonePermission()
        setup()
        
        // Do any additional setup after loading the view.
    }
    func setup() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 60, height: 60)
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing=10
        assessmentContentCV!.collectionViewLayout = layout
        assessmentContentCV?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! NewAssessmentCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/6, height: collectionViewSize/5)
    }
    @IBAction func submitButton(_ sender: Any) {
        let url=getDocumentsDirectory().appendingPathComponent("recording.m4a")
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(url, withName: "recording.m4a")
        },
            to: TaskManager.serverIP + "TestService/uploadFile",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
    }
    ////////////////////////////////////////////////Recording///////////////////////////////////////////////////////////////
    @IBAction func recordButton(_ sender: Any) {
        if audioRecorder == nil {
            playRecordingOutlet.isEnabled = false
            submitButtonOutlet.isEnabled = false
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    @IBAction func playRecording(_ sender: Any) {
        let url=getDocumentsDirectory().appendingPathComponent("recording.m4a")
        if(FileManager.default.fileExists(atPath: url.path)) {
            print("File exists",url.path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else { return }
                player.volume = 1
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
            
        } else {
            print("file not found")
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func getMicroPhonePermission(){
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() {allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Permission granted")
                    } else {
                        print("Permission not granted")
                    }
                }
            }
        } catch {
            print("Failed to record")
        }
    }
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self as? AVAudioRecorderDelegate
            audioRecorder.record()
            
            recordButtonOutlet.setTitle("Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        playRecordingOutlet.isEnabled = true
        submitButtonOutlet.isEnabled = true
        if success {
            recordButtonOutlet.setTitle("Re-record", for: .normal)
        } else {
            recordButtonOutlet.setTitle("Record", for: .normal)
            // recording failed :(
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
