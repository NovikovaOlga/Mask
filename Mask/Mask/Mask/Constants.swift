
import Foundation
import UIKit

class Constant {
    
    static let shared = Constant()
    
    // MARK: - glasses
    let urlStandard = Bundle.main.url(forResource: "Glasses",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsGlasses.scnassets")
    
    let urlGoldRing = Bundle.main.url(forResource: "Glasses_06",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsGlasses.scnassets")
    
    let urlHeart = Bundle.main.url(forResource: "Heart-shaped_glasses",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsGlasses.scnassets")
    
    let urlNeonParty = Bundle.main.url(forResource: "Neon_Party_Glasses",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsGlasses.scnassets")
    
    let urlPineapple = Bundle.main.url(forResource: "Pineapple_Glasses",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsGlasses.scnassets")
    
    let urlSteampunk = Bundle.main.url(forResource: "Steampunk_Glasses_Free",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsGlasses.scnassets")
    
    let urlSteampunkSkin = Bundle.main.url(forResource: "Steampunk_Glasses-2",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsGlasses.scnassets")
    
    let urlSteampunkRed = Bundle.main.url(forResource: "Steampunk_Glasses-3",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsGlasses.scnassets")
    
    let urlSteampunkMin = Bundle.main.url(forResource: "steampunk_glasses",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsGlasses.scnassets")
    
    // MARK: - moustache
    
   
    let urlBeardStandard = Bundle.main.url(forResource: "MOSTACHE",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsBeard.scnassets") //
    
    let urlBeardBandana = Bundle.main.url(forResource: "Bandana_Mask",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsBeard.scnassets")
    
    let urlBeardSciFi = Bundle.main.url(forResource: "Sci-fi_half_mask",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsBeard.scnassets")
    
    let urlBeardDay1 = Bundle.main.url(forResource: "Day1_Respirator",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsBeard.scnassets")
    
    let urlBeardSamurai = Bundle.main.url(forResource: "Samurai_Mask_Model_2",
                                      withExtension: "usdz",
                                      subdirectory: "ModelsBeard.scnassets")
    
    // MARK: - button icon
    // icon sceneView
    let iconGlasses = UIImage(systemName: "eyeglasses", withConfiguration:UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.tintColor, renderingMode: .alwaysOriginal)
    
    let iconCamera = UIImage(systemName: "camera", withConfiguration:UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.tintColor, renderingMode: .alwaysOriginal)
    
    let iconMoustache = UIImage(systemName: "mustache", withConfiguration:UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.tintColor, renderingMode: .alwaysOriginal)
    
    // icon snapshot
    let iconSquare = UIImage(systemName: "square.and.arrow.up", withConfiguration:UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.tintColor, renderingMode: .alwaysOriginal)
    
    let iconOk = UIImage(systemName: "checkmark", withConfiguration:UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.tintColor, renderingMode: .alwaysOriginal)
    
    let iconCancel = UIImage(systemName: "multiply", withConfiguration:UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.tintColor, renderingMode: .alwaysOriginal)
    
}
