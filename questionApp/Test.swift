/*!
@header Test.swift

@brief This file contains the Test class which contains information about test results saved for the test.
@discussion Persistence: The class conforms to NSCoding protocol and can therefor persist it's history property. The history property is typically acquired from a TestHistories or TestProfiles object. When either of those objects is persisted any changes made to the test history of this Test object will be persisted as part of that source object's archiver chain.
@discussion Direct archiving & unarchiving methods have also been provided in anticipation that it may be desired to persist the Test Object in it's own archive (independent from the archive created when saving a TestProfiles object.)

Created on 7/28/15

@author John Bateman

@copyright 2015 Qidza, Inc.
*/


import Foundation

class Test: NSObject, NSCoding {
    
    /* Contains metadata describing the results of previous tests. */
    var history = TestHistory()
    
    // Test names used to identify tests programmatically.
    struct TestNames {
        static var pupilResponse: String = "pupil response"
        static var fallingToy: String = "falling toy"
        static var letsCrawl: String = "let's crawl"
        static var pointFollowing: String = "point following"
        static var hearing: String = "hearing"
        static var crossingEyes: String = "crossing eyes"
        static var attentionAtDistance: String = "attention at distance"
        static var symmetry: String = "symmetry"
        static var pincer: String = "pincer"
        static var completelyCoveredToy : String = "completely covered toy"
        static var partiallyCoveredToy : String = "partially covered toy"
        static var selfRecognition : String = "self recognition"
        static var socialSmiling: String = "social smiling"
        static var facialMimic: String = "facial mimic"
        static var unassistedSitting: String = "unassisted sitting"
        static var sittingAndReaching: String = "sitting and reaching"
        static var plasticJar: String = "ask and respond"
        static var bookPresentation: String = "book presentation"
        // TODO: add additional var as new tests are added to the app
    }
    
    // Test names displayed to user in GUI.
    struct TestNamesPresentable {
        static var pupilResponse = "pupil response"
        static var fallingToy = "falling toy"
        static var letsCrawl = "let's crawl"
        static var pointFollowing = "point following"
        static var hearing = "hearing"
        static var crossingEyes = "crossing eyes"
        static var attentionAtDistance = "attention at distance"
        static var symmetry = "symmetry"
        static var pincer = "pincer"
        static var completelyCoveredToy = "completely covered toy"
        static var partiallyCoveredToy = "partially covered toy"
        static var selfRecognition = "self recognition"
        static var socialSmiling = "social smiling"
        static var facialMimic = "facial mimic"
        static var unassistedSitting = "unassisted sitting"
        static var sittingAndReaching = "sitting and reaching"
        static var plasticJar = "ask and respond"                  // ask and respond
        static var bookPresentation: String = "book presentation"

        // TODO: if new tests are added to the app, add them here.
    }
    
    static let SecondsInADay : Double = 24 * 60 * 60
    
    // TODO: Calculate notification intervals for each test dynamically based on baby's age and the information in this spreadsheet:  https://docs.google.com/spreadsheets/d/1AJwH6R7VfBu6IwsA88cyqpLWZf4Q75u2IkPQXbf_eqI/edit#gid=0
    
    // Local Notification interval in seconds
    struct NotificationInterval {
        static var pupilResponse:       Double =  2 * Test.SecondsInADay
        static var fallingToy:          Double = 30 * Test.SecondsInADay
        static var letsCrawl:           Double = 21 * Test.SecondsInADay
        static var pointFollowing:      Double = 21 * Test.SecondsInADay
        static var hearing:             Double =  2 * Test.SecondsInADay
        static var crossingEyes:        Double =  7 * Test.SecondsInADay
        static var attentionAtDistance: Double =  7 * Test.SecondsInADay
        static var symmetry:            Double = 30 * Test.SecondsInADay
        static var pincer:              Double = 30 * Test.SecondsInADay
        static var completelyCoveredToy: Double = 14 * Test.SecondsInADay
        static var partiallyCoveredToy: Double = 14 * Test.SecondsInADay
        static var selfRecognition :    Double = 30 * Test.SecondsInADay
        static var socialSmiling:       Double =  7 * Test.SecondsInADay
        static var facialMimic:         Double = 30 * Test.SecondsInADay
        static var unassistedSitting:   Double = 30 * Test.SecondsInADay
        static var sittingAndReaching:  Double = 30 * Test.SecondsInADay
        static var plasticJar:          Double = 30 * Test.SecondsInADay  // ask and respond
        static var bookPresentation:    Double = 30 * Test.SecondsInADay
        //static var commandWithGesture:  Double = 30 * Test.SecondsInADay
        //static var lateralTracking:          Double =  7 * Test.SecondsInADay
        //static var stranger:                 Double = 21 * Test.SecondsInADay
        //static var emotionalAttachment:      Double = 30 * Test.SecondsInADay
        //static var rollingOverBackToFront:   Double = 30 * Test.SecondsInADay
        //static var rollingOverFrontToBack:   Double = 30 * Test.SecondsInADay
        // TODO: add additional var as new tests are added to the app
    }
    
    // Represents the order in which tests are presented in the UI using Test.TestNamesPresentable values.
    static let testsInPresentedOrder = [
        TestNamesPresentable.pupilResponse,
        TestNamesPresentable.crossingEyes,
        TestNamesPresentable.hearing,
        TestNamesPresentable.letsCrawl,
        TestNamesPresentable.symmetry,
        TestNamesPresentable.pincer,
        TestNamesPresentable.unassistedSitting,
        TestNamesPresentable.sittingAndReaching,
        TestNamesPresentable.fallingToy,
        TestNamesPresentable.attentionAtDistance,
        TestNamesPresentable.partiallyCoveredToy,
        TestNamesPresentable.completelyCoveredToy,
        TestNamesPresentable.plasticJar,            // ask and respond
        TestNamesPresentable.pointFollowing,
        TestNamesPresentable.selfRecognition,
        TestNamesPresentable.socialSmiling,
        TestNamesPresentable.facialMimic
        // TODO: if new tests are added to the app, add them here in the order that they appear in the app.
    ]
    
//    static let initialStoryboardIDs = [
//        TestNamesPresentable.pupilResponse : "WhyIsPupilResponseStoryboardID",
//        TestNamesPresentable.crossingEyes : "WhyIsCrossingEyesStoryboardID",
//        TestNamesPresentable.hearing : "WhyIsHearingStoryboardID",
//        TestNamesPresentable.letsCrawl : "WhyIsCrawlingViewControllerStoryboardID",
//        TestNamesPresentable.symmetry : "WhyIsSymmetryStoryboardID",
//        TestNamesPresentable.pincer : "WhyIsPincerStoryboardID",
//        TestNamesPresentable.unassistedSitting : "WhyIsUnassistedSittingStoryboardID",
//        TestNamesPresentable.sittingAndReaching : "WhyIsSittingAndReachingStoryboardID",
//        TestNamesPresentable.fallingToy : "WhyIsObjectPermanenceViewController",
//        TestNamesPresentable.attentionAtDistance : "WhyIsAttentionAtDistanceStoryboardID",
//        TestNamesPresentable.partiallyCoveredToy : "WhyIsPartiallyCoveredToyStoryboardID",
//        TestNamesPresentable.completelyCoveredToy : "WhyIsCompletelyCoveredToyStoryboardID",
//        TestNamesPresentable.plasticJar : "WhyIsPlasticJarStoryboardID", // ask and respond
//        TestNamesPresentable.pointFollowing : "WhyIsPointFollowingStoryboardID",
//        TestNamesPresentable.selfRecognition : "WhyIsSelfRecognitionStoryboardID",
//        TestNamesPresentable.socialSmiling : "WhyIsSocialSmilingStoryboardID",
//        TestNamesPresentable.facialMimic : "WhyIsFacialMimicStoryboardID",
//        TestNamesPresentable.bookPresentation : "WhyIsBookPresentationStoryboardID"
//        // TODO: if new tests are added to the app, add them here
//    ]
    
    /* Designated initializer: initialize the Test instance with default values. */
    override init() {
        super.init()
    }
    
    /* Convenience initializer: initialize the Test instance with a TestHistory object. */
    convenience init(testHistory: TestHistory) {
        self.init()
        history = testHistory
    }
    
    /*
    @brief Initialize this Test instance from the Parent object's current profile (where the profile is identified by parent+child names).
    @discussion The test data is initialized from the store on disk.
    @param parent (in) A Parent object. (cannot be nil)
    @param testName (in) Name of the test. Must be of Test.TestNames. (cannot be nil)
    @return Returns the requested Test object.
    */
//    convenience init(parent: Parent, testName: String) {
//        self.init()
//        
//        // Get the name of the current profile from the Parent.
//        let profile = parent.getCurrentProfileName()
//        
//        // Get the test histories for the current profile.
//        let histories = parent.testProfiles.getTestHistories(profileName: profile)
//    
//        // Get the particular test we want.
//        //let test
//        let history = histories.getTestHistory(testName: testName)
//        
//        //let test = histories.getTest(testName)
//        //return test
//    }
    
    /*!
    @brief Set the history for this instance to the specified testHistory.
    @discussion Test objects are instantiated by default with a TestHistory initialized to default values.
    @param testHistory (in) The TestHistory object to attach to this Test instance. (cannot be nil)
    */
    func addHistory(testHistory: TestHistory) {
        history = testHistory
    }
    
    /*!
    @brief Update the most recent test result in the test history.
    @discussion This function automatically updates the test date to the current date & time, and updates the test counters.
    @param testResult (in) is the result of the test that the caller wishes to apply to the test hsitory.
    @return true if the test result was successfully updated, else false if an error occurred.
    */
    func addTestResult(testResult result: Bool?) -> Bool {
        
        if let result = result {
            // update the most recent result
            history.mostRecentTestResult = result
            
            // update test date to current date/time
            let testDate = NSDate()
            history.mostRecentTestDate = testDate
            
            // update test counts
            history.countOfCompletedTests += 1
            if result == true {
                history.countOfSuccessfulTests += 1
                history.succeededTestDate = testDate
            } else {
                history.countOfFailedTests += 1
            }
            
            return true
        } else {
            return false
        }
    }
    
    /*
    @brief Identifies if most recent test succeeded.
    @discussion Will return false if there is a successful test but it was not the most recent test.
    @return true if most recent test result succeeded and number of successful tests > 0, else returns false.
    */
    func succeeded() -> Bool {
        
        if history.countOfSuccessfulTests > 0 && history.mostRecentTestResult == true {
            return true
        } else {
            return false
        }
    }
    
    /*
    @brief Identifies if the test has succeeded at least once.
    @discussion Will return true if there is a successful test but it was not the most recent test.
    @return true if number of successful tests > 0, else returns false.
    */
    func everSucceeded() -> Bool {
        if history.countOfSuccessfulTests > 0 {
            return true
        } else {
            return false
        }
    }
    
    /*
    @brief Returns the most recent date when the test succeeded.
    @discussion Call everSucceeded() to determine if the test has been successfully completed.
    @return Date test succeeded, else returns nil if the test has never succeeded.
    */
    func getTestSucceededDate() -> NSDate? {
        return history.succeededTestDate
    }
    
    /*
    @brief Get the number of tests that have been run.
    @return The number of completed tests.
    */
    func testCount() -> Int {
        return history.countOfCompletedTests
    }
    
    /*
    @brief Get the number of failed tests.
    @return The number of failed tests.
    */
    func failedTestsCount() -> Int {
        return history.countOfFailedTests
    }
  
  /*
@brief Number of passed tests
*/
  var passedTests:Int {
    get {
      return history.countOfSuccessfulTests
    }
  }
    
    
    // MARK: NSCoding
    /* @discussion These methods support archiving the history property as part of a chain of archived objects when a TestProfiles object is archived. */
    
    required init(coder unarchiver: NSCoder) {
        super.init()
        decodeWithCoder(coder: unarchiver)
    }
    
    /*!
    @brief Set instance properties to values read from the persistent store.
    @discussion Will set an instance property to it's default value if the corresponding NSUnarchiver key does not exist.
    @param coder (in) The NSUnarchiver object identifying the persistent store from which to read the property values.
    */
    func decodeWithCoder(coder decoder: NSCoder) {
        
        // returns nil if key does not exist, or if value is nil
        if let testHistory = decoder.decodeObjectForKey("history") as! TestHistory? {
            self.history = testHistory
        } else {
            self.history = TestHistory()
        }
    }
    
    /*!
    @brief Write instance properties to the persistent store.
    @param encoder (in) The NSUnarchiver object identifying the persistent store to which to wrte the property values.
    */
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(self.history, forKey: "history")
    }
    
    
    // MARK: Direct archiving & unarchiving
    /* Use these methods to persist the Test Object in it's own archive (independent from the archive created when saving a TestProfiles object.) */
    
    // The name of the file where the test history data is persisted
    let archiveFilename = "TestArchive"
    
    /** Computed property for the path to the file where the data is persisted. */
    var filePath : String {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
        return url.URLByAppendingPathComponent(self.archiveFilename).path!
    }
    
    /*!
    @brief Initialize the Test instance from the test history data in the persistent store at filePath.
    @discussion Returns a valid object initialized to default values if no previous persisted instance exists.
    @return true if successfully initialized from a previously persisted instance, else false if no previous instance existed.
    */
    func initFromPersistentStore() -> Bool {
        
        if let unarchivedHistory = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath) as? TestHistory {
            self.history = unarchivedHistory
            self.history.print()
            return true
        } else {
            return false
        }
    }
    
    /*!
    @brief Write the test history to the persistant data store.
    @return true if successfully persisted, else false if an error occurred.
    */
    func save() -> Bool {
        return NSKeyedArchiver.archiveRootObject(self.history, toFile: self.filePath)
    }
    
    /*!
    @brief Return the storyboard ID of the initial view controller in the test sequence identified by testName.
    @param (in) testName - The name of the test. Must be a Test.TestNamesPresentable value. (cannot be nil)
    @return A String representing the storyboard ID. If testName is not a valid test name the function returns nil.
    */
//    static func getInitialStoryboardID(testName: String) -> String? {
//        if let storyboardID = Test.initialStoryboardIDs[testName] {
//            return storyboardID
//        } else {
//            return nil
//        }
//    }
}