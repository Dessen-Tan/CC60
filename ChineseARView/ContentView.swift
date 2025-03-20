import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate  {
    
    var arView: ARView!
    var label: UILabel!
    var hasPlacedMooncake = false // Prevent multiple placements
    let textArray = [
        "Hello, I am Bryan.",
        "This is my school.",
        "I love coding!",
        "Thanks for reading!"
    ]
    var textUpdateTimer: Timer?
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize ARView
        arView = ARView(frame: self.view.frame)
        self.view.addSubview(arView)
        
        // Add label
        label = UILabel()
        label.text = "Searching for a plane..."
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            label2.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 250),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Configure AR session with plane detection
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        
        // Set AR session delegate
        arView.session.delegate = self
        
        // Add tap gesture recognizer
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
    }
    
    // Detect new planes
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard !hasPlacedMooncake else { return } // Ensure only one Mooncake is placed
        
        for anchor in anchors {
            if let planeAnchor = anchor as? ARPlaneAnchor {
                // Update label to indicate that the plane was found
                label.text = "Plane detected! Tap to place Mooncake."
                
                startSequentialTextDisplay()
                
            }
        }
    }
    
    // Handle tap gesture to place additional Mooncakes
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: arView)
        let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let firstResult = results.first {
            let worldPos = simd_make_float3(firstResult.worldTransform.columns.3)
            if let mooncake = createMoonCake() {
                placeObject(object: mooncake, at: worldPos)
            } else {
                print("Failed to load Mooncake model")
            }
        }
    }
    
    func createMoonCake() -> ModelEntity? {
        guard let moonCakeModel = try? Entity.loadModel(named: "Mooncake") else {
            print("Failed to load Mooncake model")
            return nil
        }
        moonCakeModel.generateCollisionShapes(recursive: true)
        return moonCakeModel
    }
    
    func placeObject(object: ModelEntity, at location: SIMD3<Float>) {
        let objectAnchor = AnchorEntity(world: location)
        objectAnchor.addChild(object)
        arView.scene.addAnchor(objectAnchor)
    }
    func startSequentialTextDisplay() {
            // Reset index to start from the first text
            currentIndex = 0
            updateText()
            
            // Create a timer to update the label every 10 seconds
            textUpdateTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateText), userInfo: nil, repeats: true)
        }
    @objc func updateText() {
            if currentIndex < textArray.count {
                label.text = textArray[currentIndex]
                currentIndex += 1
            } else {
                // Stop the timer once all text is displayed
                textUpdateTimer?.invalidate()
                textUpdateTimer = nil
            }
        }
}
