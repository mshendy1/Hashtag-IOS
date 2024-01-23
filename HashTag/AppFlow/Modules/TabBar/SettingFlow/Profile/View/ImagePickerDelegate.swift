
//
//  File.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

import Foundation
import UIKit
import Photos
import QCropper

extension UserProfileVC {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func authorisationStatus(attachmentTypeEnum: AttachmentType){
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            if attachmentTypeEnum == AttachmentType.camera{
                openCamera()
            }
            if attachmentTypeEnum == AttachmentType.photoLibrary{
                photoLibrary()
            }
        case .denied:
            print("permission denied")
        case .notDetermined:
            print("Permission Not Determined")
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized{
                    // photo library access given
                    print("access given")
                    if attachmentTypeEnum == AttachmentType.camera{
                        self.openCamera()
                    }
                    if attachmentTypeEnum == AttachmentType.photoLibrary{
                        self.photoLibrary()
                    }
                }else{
                    print("restriced manually")
                }
            })
        case .restricted:
            print("permission restricted")
        default:
            break
        }
    }
    
    //MARK: - CAMERA PICKER
    //This function is used to open camera from the iphone and
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            myPickerController.allowsEditing = false
            present(myPickerController, animated: true, completion: nil)
        }
    }
    
    //MARK: - PHOTO PICKER
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            DispatchQueue.main.async {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .photoLibrary
                myPickerController.allowsEditing = false
                self.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    
}
