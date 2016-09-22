//
//  Camera.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/19/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class Camera: SKCameraNode {
    
    // MARK: - Private enum for camera zoom levels
    private enum Zoom {
        case near, standard
    }
    
    // MARK: - Private class variables
    private var zoomLevel:Zoom = .standard
    
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.position = kScreenCenter
        
        stateRunning()
    }
    
    // MARK: - Update
    func update() {
        // Set Zoom Level
        switch zoomLevel {
        case .near:
            zoomIn()
            
        case .standard:
            zoomStandard()
        }
    }
    
    // MARK: - Zoom
    private func zoomIn() {
        zoomLevel = .near
        
        let zoom = CGPoint(x: 0.75, y: 0.75)
        
        self.scaleAsPoint = SmoothedPoint(startPoint: self.scaleAsPoint, endPoint: zoom, percent: 0.1)
    }
    
    private func zoomStandard() {
        zoomLevel = .standard
        
        let zoom = CGPoint(x: 1.0, y: 1.0)
        
        self.scaleAsPoint = SmoothedPoint(startPoint: self.scaleAsPoint, endPoint: zoom, percent: 0.1)
    }
    
    func stateRunning() {
        zoomStandard()
    }
    
    func stateGameOver() {
        zoomIn()
    }

}
