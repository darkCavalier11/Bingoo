//
//  LocalNetworkSessionCoordinator.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 22/11/24.
//

import Foundation
import Combine
import MultipeerConnectivity

private var cancellable = Set<AnyCancellable>()

@Observable
class LocalNetworkSessionCoordinator: NSObject, BingoCommunication {
  private let messageSubject: CurrentValueSubject<BingoMessageModel, Never> = .init(.waitingForPlayerToJoin(hostProfile: BingoUserProfile.current))
  var messagePublisher: AnyPublisher<BingoMessageModel, Never> {
    messageSubject.eraseToAnyPublisher()
  }
  
  var canSendEvent: Bool = false
  
  var host: BingoUserProfile?
  
  var joinee: BingoUserProfile?
  
  let isHost: Bool
  private let advertiser: MCNearbyServiceAdvertiser
  private let browser: MCNearbyServiceBrowser
  private let session: MCSession
  
  private(set) var allDevices: Set<MCPeerID> = []
  private(set) var connectedDevices: Set<MCPeerID> = []
  var otherDevices: Set<MCPeerID> {
    return allDevices.subtracting(connectedDevices)
  }
  private(set) var message: String = ""
  
  private let incomingInvitationPeerSubject = CurrentValueSubject<MCPeerID?, Never>(nil)
  var incomingInvitationPeers: AnyPublisher<MCPeerID?, Never>!
  let acceptingInvitationPeerSubject = CurrentValueSubject<MCPeerID?, Never>(nil)
  
  init(isHost: Bool, peerID: MCPeerID = .init(displayName: UIDevice.current.name)) {
    advertiser = .init(
      peer: peerID,
      discoveryInfo: nil,
      serviceType: .messageSendingService
    )
    browser = .init(
      peer: peerID,
      serviceType: .messageSendingService
    )
    session = .init(peer: peerID)
    self.isHost = isHost
    super.init()
    incomingInvitationPeers = incomingInvitationPeerSubject.eraseToAnyPublisher()
    
    advertiser.delegate = self
    browser.delegate = self
    session.delegate = self
  }
  
  public func startAdvertising() {
    advertiser.startAdvertisingPeer()
  }
  
  public func stopAdvertising() {
    advertiser.stopAdvertisingPeer()
  }
  
  public func startBrowsing() {
    browser.startBrowsingForPeers()
  }
  
  public func stopBrowing() {
    browser.stopBrowsingForPeers()
  }
  
  public func invitePeer(peerID: MCPeerID) {
    browser.invitePeer(
      peerID,
      to: session,
      withContext: nil,
      timeout: 120
    )
  }
  
  func sendEvent(message: BingoMessageModel) throws {
    let encoder = JSONEncoder()
    let data = try encoder.encode(message)
    try session.send(
      data,
      toPeers: Array(connectedDevices),
      // .reliable = TCP
      // .unreliable = UDP
      // Remember that we have added two set of configuration on the Info.plist
      // file at the time of configuration. We want guranteed message delivery
      // so we choose TCP/.reliable.
      with: .reliable
    )
    messageSubject.send(message)
  }
}

extension LocalNetworkSessionCoordinator: MCNearbyServiceAdvertiserDelegate {
  func advertiser(
    _ advertiser: MCNearbyServiceAdvertiser,
    didReceiveInvitationFromPeer peerID: MCPeerID,
    withContext context: Data?,
    invitationHandler: @escaping (Bool, MCSession?) -> Void
  ) {
    incomingInvitationPeerSubject.send(peerID)
    acceptingInvitationPeerSubject.sink { [weak self] peerID in
      guard peerID != nil else { return }
      invitationHandler(true, self?.session)
    }
    .store(in: &cancellable)
  }
}

extension LocalNetworkSessionCoordinator: MCNearbyServiceBrowserDelegate {
  func browser(
    _ browser: MCNearbyServiceBrowser,
    foundPeer peerID: MCPeerID,
    withDiscoveryInfo info: [String : String]?
  ) {
    allDevices.insert(peerID)
  }
  
  func browser(
    _ browser: MCNearbyServiceBrowser,
    lostPeer peerID: MCPeerID
  ) {
    allDevices.remove(peerID)
  }
  
}

extension LocalNetworkSessionCoordinator: MCSessionDelegate {
  func session(
    _ session: MCSession,
    peer peerID: MCPeerID,
    didChange state: MCSessionState
  ) {
    if state == .connected {
      connectedDevices.insert(peerID)
      if !isHost {
        try? sendEvent(message: .playerJoined(userProfile: BingoUserProfile.current))
      }
    } else {
      connectedDevices.remove(peerID)
      try? sendEvent(message: .failure(reason: "\(BingoUserProfile.current.userName) disconnected"))
    }
  }
  
  func session(
    _ session: MCSession,
    didReceive data: Data,
    fromPeer peerID: MCPeerID
  ) {
    let decoder = JSONDecoder()
    guard let message = try? decoder.decode(BingoMessageModel.self, from: data) else {
      return
    }
    messageSubject.send(message)
    if case BingoMessageModel.playerJoined(userProfile: let userProfile) = message {
      host = BingoUserProfile.current
      joinee = userProfile
      if isHost {
        try? sendEvent(
          message: .started(
            host: BingoUserProfile.current,
            joinee: userProfile
          )
        )
        messageSubject.send(
          .started(
            host: BingoUserProfile.current,
            joinee: userProfile
          )
        )
      }
    }
  }
  
  func session(
    _ session: MCSession,
    didReceive stream: InputStream,
    withName streamName: String,
    fromPeer peerID: MCPeerID
  ) {
    
  }
  
  func session(
    _ session: MCSession,
    didStartReceivingResourceWithName resourceName: String,
    fromPeer peerID: MCPeerID,
    with progress: Progress
  ) {
    
  }
  
  func session(
    _ session: MCSession,
    didFinishReceivingResourceWithName resourceName: String,
    fromPeer peerID: MCPeerID,
    at localURL: URL?,
    withError error: (any Error)?
  ) {
    
  }
}

private extension String {
  static let messageSendingService = "sendMsgModel"
}

