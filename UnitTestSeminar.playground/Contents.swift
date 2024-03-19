import Foundation


public final class Tracker {
    private init() { }
    
    public static let shared = Tracker()
    
    public func track(event: String) {
        print("Event \(event)")
    }
}
/// ------------
protocol TrackingLogic {
    func track(event: String)
}

extension Tracker: TrackingLogic { }

final class Analytics {
    private let tracker: TrackingLogic
    
    init(tracker: TrackingLogic = Tracker.shared) {
        self.tracker = tracker
    }

    func trackScreen() {
        tracker.track(event: "Hello")
        tracker.track(event: "Screen")
    }
}


final class MockTracker: TrackingLogic {
    var tracked = [String]()
    
    func track(event: String) {
        tracked.append(event)
    }
    
    
}

func testAnalytics() -> Bool {
    // Arrange
    let tracker: MockTracker = MockTracker()
    let analytics: Analytics = Analytics(tracker: tracker)
    let expectedResult: [String] = ["Screen"]
    // Act
    analytics.trackScreen()
    // Assert
    return expectedResult == tracker.tracked
}


testAnalytics()
