
import ARKit
import SceneKit

enum GlassesType {
    case standard
    case goldRing
    case heart
    case neonParty
    case pineapple
    case steampunk
    case steampunkSkin
    case steampunkRed
    case steampunkMin
}

class Glasses: SCNNode {
    
    let occlusionNode: SCNNode // узел перекрытия объекта дополненной реальности и физического объекта (лица)
    
    var nodeGlasses: SCNReferenceNode // узел очков
    
    init(geometry: ARSCNFaceGeometry, glassesType: GlassesType) { // принимает геометрию лица пользователя
        
        // глубина рендеринга
        geometry.firstMaterial!.colorBufferWriteMask = []
        occlusionNode = SCNNode(geometry: geometry)
        occlusionNode.renderingOrder = -1
        nodeGlasses = SCNReferenceNode()
        
        super.init()
        
        addChildNode(occlusionNode) // добавляем узел перекрытия в сцену
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    func swapGlasses(glassesType: GlassesType) {
        
        switch glassesType {
        case .standard:
            // проверим, существует ли объект в основном пакете
            guard let url = Constant.shared.urlStandard else {
                fatalError("Missing resource: urlStandard") }
            masterNodeGlasses(url: url)
        case .goldRing:
            guard let url = Constant.shared.urlGoldRing else {
                fatalError("Missing resource: urlGoldRing") }
            masterNodeGlasses(url: url)
        case .heart:
            guard let url = Constant.shared.urlHeart else {
                fatalError("Missing resource: urlHeart") }
            masterNodeGlasses(url: url)
        case .neonParty:
            guard let url = Constant.shared.urlNeonParty else {
                fatalError("Missing resource: urlNeonParty") }
            masterNodeGlasses(url: url)
        case .pineapple:
            guard let url = Constant.shared.urlPineapple else {
                fatalError("Missing resource: urlPineapple") }
            masterNodeGlasses(url: url)
        case .steampunk:
            guard let url = Constant.shared.urlSteampunk else {
                fatalError("Missing resource: urlSteampunk") }
            masterNodeGlasses(url: url)
        case .steampunkSkin:
            guard let url = Constant.shared.urlSteampunkSkin else {
                fatalError("Missing resource: urlSteampunkSkin") }
            masterNodeGlasses(url: url)
        case .steampunkRed:
            guard let url = Constant.shared.urlSteampunkRed else {
                fatalError("Missing resource: urlSteampunkRed") }
            masterNodeGlasses(url: url)
        case .steampunkMin:
            guard let url = Constant.shared.urlSteampunkMin else {
                fatalError("Missing resource: urlSteampunkMin") }
            masterNodeGlasses(url: url)
        }
    }
    
    func masterNodeGlasses(url: URL) {
        nodeGlasses.removeFromParentNode()
        // создаем ссылочный узел и загружаем его
        nodeGlasses = SCNReferenceNode(url: url)!
        nodeGlasses.load()
        // добавляем все из файла в сцену
        addChildNode(nodeGlasses)
    }
    
    // функция для обновления привязки лица
    func update(withFaceAnchor anchor: ARFaceAnchor) {
        let faceGeometry = occlusionNode.geometry as! ARSCNFaceGeometry
        faceGeometry.update(from: anchor.geometry)
    }
}

