//
//  SegmentAnalyticsService.swift
//  edXMobileAnalytics
//
//  Created by Saeed Bashir on 12/3/24.
//

import Foundation
import OEXFoundation
import Segment
import SegmentFirebase

class SegmentAnalyticsService: AnalyticsService {
    var analytics: Analytics?
    // Init manager
    public init(_ key: String, isSegentFirebaseEnabled: Bool) {
        let configuration = Configuration(writeKey: key)
            .trackApplicationLifecycleEvents(true)
            .flushInterval(10)
        analytics = Analytics(configuration: configuration)
        if isSegentFirebaseEnabled {
            analytics?.add(plugin: FirebaseDestination())
        }
    }

    func identify(id: String, username: String?, email: String?) {
        guard let email = email, let username = username else { return }
        let traits: [String: String] = [
            "email": email,
            "username": username
        ]
        analytics?.identify(userId: id, traits: traits)
    }

    func logEvent(_ event: String, parameters: [String: Any]?) {
        analytics?.track(
            name: event,
            properties: parameters
        )
    }

    func logScreenEvent(_ event: String, parameters: [String: Any]?) {
        analytics?.screen(title: event, properties: parameters)
    }
}
