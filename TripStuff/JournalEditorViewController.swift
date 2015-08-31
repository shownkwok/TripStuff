//
//  JournalEditorViewController.swift
//  TripStuff
//
//  Created by SHAWN on 8/5/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit
import MobileCoreServices

class JournalEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    struct Constant {
        static let ShowEditedSegueID = "showEdited"
    }
    
    var journal: JournalClass?{
        didSet{
            print(journal)
            if journal != nil{
                titleInput.text = journal?.journalTitle
                detailInput.text = journal?.journalDetail
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var imageView = UIImageView()
    @IBOutlet weak var imagePicker: UIView!{
        didSet{
            imageView.frame = CGRectMake(100, 100, 200, 200)
            imagePicker.addSubview(imageView)
        }
    }

    @IBOutlet weak var titleInput: UITextField!

    @IBAction func camara(sender: UIButton) {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable( UIImagePickerControllerSourceType.Camera){
            picker.sourceType = .Camera
            picker.mediaTypes = [kUTTypeImage as String]
            picker.delegate = self
            picker.allowsEditing = true
        }
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageCollection: UICollectionView!
    
    @IBOutlet weak var detailInput: UITextView!
    
    @IBAction func done(sender: UIButton) {
        if titleInput.text != ""{
            journal = JournalClass(journalTitle: titleInput.text!)
            journal?.journalDetail = detailInput.text
            performSegueWithIdentifier(Constant.ShowEditedSegueID, sender: self)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var image = info[UIImagePickerControllerEditedImage] as? UIImage
        if image == nil{
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        imageView.image = image
        print(image)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

// MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! JournalTableViewController
            if segue.identifier == Constant.ShowEditedSegueID{
                viewController.journalChanged = journal
            }
    }
}
