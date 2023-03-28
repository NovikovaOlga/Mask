
import UIKit
import ARKit

/* у кнопок по 2 режима работы (в сценките и в снапшоте) переключается enum:
- очки + шеринг (сцена: смена очков)
 - фото + Ок (сцена: сделать фото, снапшот: сохранить в галерею)
 - усы + отмена (сцена: смена усов, снапшот: вернуться в сцену без сохранения)
*/
enum ModeViewType {
    case sceneView
    case snapshot
}

class ViewController: UIViewController {
    
    static let shared = ViewController()
 
    // MARK: - Properties
    var glasses: Glasses?
    var beard: Beard?
    
    var glassesType = GlassesType.standard // первоначальная модель и дальнейший перебор
    var beardType = BeardType.beardStandard

    var modeViewType = ModeViewType.sceneView // режим работы сцены (сценкит, снапшот)
   
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBOutlet weak var fotoCameraView: UIImageView!
    
    @IBOutlet weak var fotoButton: UIButton! { didSet {
        fotoButton.layer.cornerRadius = fotoButton.frame.size.width / 2
        fotoButton.backgroundColor = .white
    }}
    
    @IBOutlet weak var glassesButton: UIButton! { didSet {
        glassesButton.layer.cornerRadius = glassesButton.frame.size.width / 2
    }}
    
    @IBOutlet weak var moustacheButton: UIButton! { didSet {
        moustacheButton.layer.cornerRadius = moustacheButton.frame.size.width / 2
    }}
    

    @IBAction func fotoButtonTap(_ sender: Any) {
        
        switch modeViewType {
        case .sceneView:
            modeViewType = .snapshot
            fotoCameraView.image = sceneView.snapshot()
            swapModeView(modeViewType: modeViewType)
        case .snapshot:
            modeViewType = .sceneView
            UIImageWriteToSavedPhotosAlbum(fotoCameraView.image!, nil, nil, nil)
            swapModeView(modeViewType: modeViewType)
            fotoCameraView.image = nil
        }
    }

    @IBAction func glassesButtonTap(_ sender: Any) {
        
        switch modeViewType {
        case .sceneView:
            switch glassesType {
            case .standard:
                glassesType = .goldRing
            case .goldRing:
                glassesType = .heart
            case .heart:
                glassesType = .neonParty
            case .neonParty:
                glassesType = .pineapple
            case .pineapple:
                glassesType = .steampunk
            case .steampunk:
                glassesType = .steampunkSkin
            case .steampunkSkin:
                glassesType = .steampunkRed
            case .steampunkRed:
                glassesType = .steampunkMin
            case .steampunkMin:
                glassesType = .standard
            }
            
            glasses?.swapGlasses(glassesType: glassesType)
         
        case .snapshot:
            print("кнопка не используется")
        }
    }
    
    @IBAction func moustacheButtonTap(_ sender: Any) {
        
        switch modeViewType {
        case .sceneView:
            
            switch beardType {
            case .beardStandard:
                beardType = .beardBandana
            case .beardBandana:
                beardType = .beardSciFi
            case .beardSciFi:
                beardType = .beardDay1
            case .beardDay1:
                beardType = .beardSamurai
            case .beardSamurai:
                beardType = .beardStandard
            }
            
            beard?.swapBeard(beardType: beardType)
            
        case .snapshot:
          //  print("Можно добавить кнопку отмены")
            modeViewType = .sceneView
            swapModeView(modeViewType: modeViewType)
            fotoCameraView.image = nil
        }
    }
    
    var anchorNode: SCNNode? // свойство для хранения объекта привязки AR Face
    
    // запуск сеанса отслеживания лиц
    var session: ARSession {
        return sceneView.session
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
        createFaceGeometry()
        
        glasses?.swapGlasses(glassesType: glassesType)
        beard?.swapBeard(beardType: beardType)
        
        swapModeView(modeViewType: modeViewType)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = true // true предотвращает переход устройства в спящий режим
        resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = false // переход в спящий режим
        sceneView.session.pause()
    }
}

// MARK: - ARSCNViewDelegate

extension ViewController: ARSCNViewDelegate {
    
    // Tag: SceneKit Renderer
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
  
        guard let estimate = session.currentFrame?.lightEstimate else { // наличие данных в оценке освещенности
            return
        }
     
        let intensity = estimate.ambientIntensity / 1000.0 // нейтральный свет (интенсивность окружающей среды / 1000)
        sceneView.scene.lightingEnvironment.intensity = intensity
        
        // показатели интенсивности на экране (можно сделать настройки шестеренки для пользователя)
//        let intensityStr = String(format: "%.2f", intensity)
//        let sceneLighting = String(format: "%.2f",
//                                   sceneView.scene.lightingEnvironment.intensity)
//        print("Intensity: \(intensityStr) - \(sceneLighting)")
    }
    
    // Tag: ARNodeTracking
   
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        anchorNode = node // заполним anchorNode недавно добавленным узлом SceneKit (чтобы использовать этот узел в сочетании с нашим виртуальным контентом)
        setupFaceNodeContent()
    }
    
    // Tag: ARFaceGeometryUpdate
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        glasses?.update(withFaceAnchor: faceAnchor)
        beard?.update(withFaceAnchor: faceAnchor)
 
    }
    
    // Tag: ARSession Handling - Обработка ошибок и прерываний.
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("- - - didFailWithError - - -")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("- - - sessionWasInterrupted - - -")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("- - - sessionInterruptionEnded - - -")
    }
}

private extension ViewController {
    
    // Tag: SceneKit Setup
    func setupScene() {
      
        sceneView.delegate = self

        sceneView.showsStatistics = false // true - статистика сцены на экране
        
        // Setup environment
        sceneView.automaticallyUpdatesLighting = true // оценочное освещение из сцены камеры
        sceneView.autoenablesDefaultLighting = true // SceneKit автоматически добавит и разместит всенаправленный источник света при рендеринге сцен, которые не содержат источников света или содержат только окружающий свет (не все модели с установленным источником света для рендеринга сцены (н-р: ананас, золотые и тд - черные при установках освещенности по умолчанию))
        
        sceneView.scene.lightingEnvironment.intensity = 1.0 //Текстура карты куба, которая изображает окружающую среду, окружающую содержимое сцены, используется для расширенных световых эффектов.
    }
    
    // Tag: ARFaceTrackingConfiguration - настроить сеанс.
    func resetTracking() {
        guard ARFaceTrackingConfiguration.isSupported else { // устройство способно отслеживать лица
            print("Face Tracking Not Supported.")
            return
        }
        
        let configuration = ARFaceTrackingConfiguration()  // создание конфигурации для отслеживания лица
        configuration.isLightEstimationEnabled = true
        configuration.providesAudioData = false
       
        sceneView.session.run(configuration) // запуск конфигурации для отслеживания лица
    }
    
    // Tag: CreateARSCNFaceGeometry
    func createFaceGeometry() {
        
        let device = sceneView.device!

        let glassesGeometry = ARSCNFaceGeometry(device: device)!
        glasses = Glasses(geometry: glassesGeometry, glassesType: glassesType)
        
        let beardGeometry = ARSCNFaceGeometry(device: device)!
        beard = Beard(geometry: beardGeometry, beardType: beardType)
    }
    
    func setupFaceNodeContent() {
        
        guard let node = anchorNode else { return }
        node.childNodes.forEach { $0.removeFromParentNode() }
        node.addChildNode(glasses!)
        node.addChildNode(beard!)
    }
}

extension ViewController {

    func swapModeView(modeViewType: ModeViewType) {

        switch modeViewType {
        case .sceneView:
            
            // настройка элементов (buttons)
            glassesButton.setImage(Constant.shared.iconGlasses, for: .normal)
            glassesButton.imageView?.contentMode = .scaleAspectFill
            glassesButton.tintColor = .systemBackground
            glassesButton.isHidden = false

            fotoButton.setImage(Constant.shared.iconCamera, for: .normal)
            fotoButton.imageView?.contentMode = .scaleAspectFill
            fotoButton.tintColor = .systemBackground

            moustacheButton.setImage(Constant.shared.iconMoustache, for: .normal)
            moustacheButton.imageView?.contentMode = .scaleAspectFill
            moustacheButton.tintColor = .systemBackground
         

        case .snapshot:
//            glassesButton.setImage(Constant.shared.iconSquare, for: .normal)
//            glassesButton.imageView?.contentMode = .scaleAspectFill
            glassesButton.isHidden = true

            fotoButton.setImage(Constant.shared.iconOk, for: .normal)
            fotoButton.imageView?.contentMode = .scaleAspectFill
            fotoButton.tintColor = .green
            
       //     moustacheButton.isHidden = true
            moustacheButton.setImage(Constant.shared.iconCancel, for: .normal)
            moustacheButton.imageView?.contentMode = .scaleAspectFill
            moustacheButton.tintColor = .red
        }
    }
}
