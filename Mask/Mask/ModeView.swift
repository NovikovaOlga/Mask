//
//import ARKit
//import SceneKit
//
//enum ModeViewType {
//    case sceneView
//    case snapshot
//}
//
//
//class ModeView {
//    
//    func swapModeView(modeViewType: ModeViewType) {
//        
//        switch modeViewType {
//        case .sceneView:
//            // настройка элементов (buttons)
//         
//            ViewController.shared.glassesButton.setImage(Constant.shared.iconGlasses, for: .normal)
//            ViewController.shared.glassesButton.imageView?.contentMode = .scaleAspectFill
//            
//            ViewController.shared.fotoButton.setImage(Constant.shared.iconCamera, for: .normal)
//            ViewController.shared.fotoButton.imageView?.contentMode = .scaleAspectFill
//            
//            ViewController.shared.moustacheButton.setImage(Constant.shared.iconMoustache, for: .normal)
//            ViewController.shared.moustacheButton.imageView?.contentMode = .scaleAspectFill
//
//        case .snapshot:
//            ViewController.shared.glassesButton.setImage(Constant.shared.iconSquare, for: .normal)
//            ViewController.shared.glassesButton.imageView?.contentMode = .scaleAspectFill
//            
//            ViewController.shared.fotoButton.setImage(Constant.shared.iconOk, for: .normal)
//            ViewController.shared.fotoButton.imageView?.contentMode = .scaleAspectFill
//            
//            ViewController.shared.moustacheButton.setImage(Constant.shared.iconCancel, for: .normal)
//            ViewController.shared.moustacheButton.imageView?.contentMode = .scaleAspectFill
//        }
//    }
//    
//}
