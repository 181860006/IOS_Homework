//
//  ItemAddViewController.swift
//  4_MyShoppingList
//
//  Created by 陈劭彬 on 2020/11/7.
//

import UIKit
import os.log

class ItemAddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var item:Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        AddName.delegate = self
        AddReason.delegate = self
        AddWish.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    //Add Item Page
    //TextField
    @IBOutlet weak var AddName: UITextField!
    @IBOutlet weak var AddReason: UITextField!
    @IBOutlet weak var AddWish: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
    }
    //ImageView
    @IBOutlet weak var AddPhoto: UIImageView!
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        AddPhoto.image = selectedImage // 将选择的图片交付给商品图片视图
        dismiss(animated: true, completion: nil)
    }
    //TapGesture
    //https://blog.csdn.net/weixin_41454168/article/details/103011239
    @IBAction func SelectImage(_ sender: UITapGestureRecognizer)
    {
        AddName.resignFirstResponder()
        AddReason.resignFirstResponder()
        AddWish.resignFirstResponder()
        //create a choosing table
        let actionSheetController = UIAlertController()
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel,handler: nil)
        
        let takingPicturesAction = UIAlertAction(title: "拍照", style: UIAlertAction.Style.default)
        {(alertAction) -> Void in
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
        
        let photoAlbumAction = UIAlertAction(title: "相册", style: UIAlertAction.Style.default)
        {(alertAction) -> Void in
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
                    
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(takingPicturesAction)
        actionSheetController.addAction(photoAlbumAction)
            
        //iPad设备浮动层设置锚点
        //actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        self.present(actionSheetController, animated: true, completion: nil)
    }
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func unwind(_ sender: UIBarButtonItem!)
    {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else
        {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = AddName.text ?? ""
        let reason = AddReason.text ?? ""
        let wish = AddWish.text ?? ""
        let photo = AddPhoto.image
        item = Item(name, reason, wish, photo)
    }
    
}

