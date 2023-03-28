import ARKit
import SceneKit

enum BeardType {
    case beardStandard
    case beardBandana
    case beardSciFi
    case beardDay1
    case beardSamurai
}

class Beard: SCNNode {
    
    let occlusionNodeBeard: SCNNode
    
    var nodeBeard: SCNReferenceNode
    
    init(geometry: ARSCNFaceGeometry, beardType: BeardType) {
        
        // глубина рендеринга
        geometry.firstMaterial!.colorBufferWriteMask = []
        occlusionNodeBeard = SCNNode(geometry: geometry)
        occlusionNodeBeard.renderingOrder = -1
        nodeBeard = SCNReferenceNode()
        
        super.init()
        
        addChildNode(occlusionNodeBeard) // добавляем узел перекрытия в сцену
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    func swapBeard(beardType: BeardType) {
        
        switch beardType {
        case .beardStandard:
            // существует ли объект в основном пакете
            guard let url = Constant.shared.urlBeardStandard else {
                fatalError("Missing resource: urlBeardStandard") }
            masterNodeBeard(url: url)
        case .beardBandana:
            guard let url = Constant.shared.urlBeardBandana else {
                fatalError("Missing resource: urlBeardBandana") }
            masterNodeBeard(url: url)
        case .beardSciFi:
            guard let url = Constant.shared.urlBeardSciFi else {
                fatalError("Missing resource: urlBeardBandana") }
            masterNodeBeard(url: url)
        case .beardDay1:
            guard let url = Constant.shared.urlBeardDay1 else {
                fatalError("Missing resource: urlBeardBandana") }
            masterNodeBeard(url: url)
        case .beardSamurai:
            guard let url = Constant.shared.urlBeardSamurai else {
                fatalError("Missing resource: urlBeardBandana") }
            masterNodeBeard(url: url)
        }
    }
    
    func masterNodeBeard(url: URL) {
        nodeBeard.removeFromParentNode()
        // создаем ссылочный узел и загружаем его
        nodeBeard = SCNReferenceNode(url: url)!
        nodeBeard.load()
        // добавляем все из файла сцены в сцену
        addChildNode(nodeBeard)
    }
    
    // функция для обновления привязки лица
    func update(withFaceAnchor anchor: ARFaceAnchor) {
        let faceGeometry = occlusionNodeBeard.geometry as! ARSCNFaceGeometry
        faceGeometry.update(from: anchor.geometry)
    }
}
