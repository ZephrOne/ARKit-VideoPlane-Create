//
//  ViewController.swift
//  ARkit-VideoPlane-Create
//
//  Created by Bevis Shen on 2018/4/3.
//  Copyright © 2018 Bevis Shen. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        //视频文件名
        let videoNode = SKVideoNode(fileNamed: "Your Video.mp4")
        videoNode.play()
        
        let skScene = SKScene(size: CGSize(width: 640, height: 480))
        skScene.addChild(videoNode)
        
        //设定视频在skScene中的位置，注意以坐标点为几何中心点
        videoNode.position = CGPoint(x: skScene.size.width/2, y: skScene.size.height/2)
        videoNode.size = skScene.size
        
        let videoPlane = SCNPlane(width: 1.0, height: 0.75)
        
        //将skScene放置于面板中
        videoPlane.firstMaterial?.diffuse.contents = skScene
        //设置面板双面可见
        videoPlane.firstMaterial?.isDoubleSided = true
        
        let videoPlaneNode = SCNNode()
        videoPlaneNode.geometry = videoPlane
        
        //设置面板在场景中放置的位置
        videoPlaneNode.position = SCNVector3(0, 0, -0.5)
        //对面板进行180度旋转
        videoPlaneNode.eulerAngles = SCNVector3(Double.pi,0,0)
        
        scene.rootNode.addChildNode(videoPlaneNode)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
