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
    
    // Test names
    struct TestNames {
        static var pupilResponse: String = "pupil response"
        static var fallingToy: String = "falling toy"
        static var letsCrawl: String = "lets crawl"
        static var pointFollowing: String = "point following"
        static var hearing: String = "hearing"
        static var crossingEyes: String = "crossing eyes"
        static var attentionAtDistance: String = "attention at distance"
        static var symmetry: String = "symmetry"
        static var partiallyCoveredToy : String = "partially covered toy"
        static var selfRecognition : String = "self recognition"
        static var socialSmiling: String = "social smiling"
        static var FacialMimic: String = "facial mimic"
        // TODO: add additional var as new tests are added to the app
    }
    
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
    @dicsussion This function automatically updates the test date to the current date & time, and updates the test counters.
    @param testResult (in) is the result of the test that the caller wishes to apply to the test hsitory.
    @return true if the test result was successfully updated, else false if an error occurred.
    */
    func addTestResult(testResult result: Bool?) -> Bool {
        
        if let result = result {
            // update the most recent result
            history.mostRecentTestResult = result
            
            // update test date to current date/time
            history.mostRecentTestDate = NSDate()
            
            // update test counts
            history.countOfCompletedTests += 1
            if result == true {
                history.countOfSuccessfulTests += 1
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
    
    
    // MARK: NSCoding
    /* @discussion These methods support archiving the history property as part of a chain of archived objects when a TestProfiles object is archived. */
    
    required init(coder unarchiver: NSCoder) {
        super.init()
        decodeWithCoder(coder: unarchiver)
    }
    
    /*!
    @brief Set instance properties to values read from the persistent store.
    @dicsussion Will set an instance property to it's default value if the corresponding NSUnarchiver key does not exist.
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
    @dicsussion Returns a valid object initialized to default values if no previous persisted instance exists.
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
    
}