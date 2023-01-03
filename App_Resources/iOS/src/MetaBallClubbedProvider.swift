//
//  MetaBallClubbedProvider.swift
//  nativescript-ios-metaballs
//
//  Created by NathanWalker on 2022/01/02
//

import SwiftUI

@objc
class MetaBallClubbedProvider: UIViewController, SwiftUIProvider {

  // MARK: INIT

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  required public init() {
    super.init(nibName: nil, bundle: nil)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    setupSwiftUIView(content: swiftUIView)
  }

  // MARK: PRIVATE
  private var swiftUIView = MetaBallClubbed()

  /// Receive data from NativeScript
  func updateData(data: NSDictionary) {

  }

  /// Allow sending of data to NativeScript
  var onEvent: ((NSDictionary) -> ())?
}
