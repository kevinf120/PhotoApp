import UIKit
import MobileCoreServices

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate {
    var cameraUI: UIImagePickerController! = UIImagePickerController()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    //--- Take Photo from Camera ---//
    @IBAction func takePhotoFromCamera(sender: AnyObject)
    {
        self.presentCamera()
    }
    
    
    
    func presentCamera()
    {
    
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            println("Button capture")
    
            cameraUI = UIImagePickerController()
            cameraUI.delegate = self
            cameraUI.sourceType = UIImagePickerControllerSourceType.Camera;
            cameraUI.mediaTypes = [kUTTypeImage]
            cameraUI.allowsEditing = false
    
            self.presentViewController(cameraUI, animated: true, completion: nil)
        }
        else
        {
            // error msg
        }
    }
    
    //Mark- UIImagePickerController Delegate
    
    func imagePickerControllerDidCancel(picker:UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    func imagePickerController(picker:UIImagePickerController!, didFinishPickingMediaWithInfo info:NSDictionary)
    {
    if(picker.sourceType == UIImagePickerControllerSourceType.Camera)
    {
    // Access the uncropped image from info dictionary
    var imageToSave: UIImage = info.objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
    var imageToSave1: UIImage = info[UIImagePickerControllerOriginalImage]as! UIImage //same but with different way
    
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
    
    self.savedImageAlert()
    self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    }
    
    
    
    
    func savedImageAlert()
    {
    var alert:UIAlertView = UIAlertView()
    alert.title = "Saved!"
    alert.message = "Your picture was saved to Camera Roll"
    alert.delegate = self
    alert.addButtonWithTitle("Ok")
    alert.show()
    }
    
    
    
    
    
    }
    
    func saveImage (image: UIImage, path: String ) -> Bool{
        
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = pngImageData.writeToFile(path, atomically: true)
        
        return result
        
    }
    
