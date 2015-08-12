/*!
    @header TestHistories.swift

    @brief This file contains the TestHistories class which manages a dictionary of TestHistory instances. Methods are available to record and query test results for individual tests. All test histories are persisted by this class.
    
    Created on 7/19/15

    @author John Bateman

    @copyright 2015 Qidza, Inc.
*/

import Foundation

class TestHistories : NSObject, NSCoding {
    
    // key = name of the test. (See self.TestNames struct for a valid list of names.)
    // value = a TestHistory object
    var histories = [String : TestHistory]()
    
    /*
    Archive data structure
    
    // The archive is a dictionary, where key is a String identifying a test name, and where the value is a TestHistory dictionary.
    
    [String: [TestHistory]]
    
        Example:
        
        ["symmetry":
            [
                "mostRecentTestDate" : NSDate()
                "mostRecentTestResult" : false
                "countOfFailedTests" : 0
                "countOfSuccessfulTests" : 0
                "countOfCompletedTests" : 0
            ]
         "hearing":
            [
                "mostRecentTestDate" : NSDate()
                "mostRecentTestResult" : true
                "countOfFailedTests" : 0
                "countOfSuccessfulTests" : 1
                "countOfCompletedTests" : 1
            ]
         ...
        ]
    */
    
    // The name of the file where the test history data is persisted
    let archiveFilename = "TestHistoryArchive"
    
    /** Computed property for the path to the file where the data is persisted. */
    var filePath : String {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
        return url.URLByAppendingPathComponent(self.archiveFilename).path!
    }
    
    override init() {
        super.init()
        initHistories()
    }
    
    /*!
        @brief Initialize the TestHistories instance setting all test histories to default values.
    */
    func initHistories() {
        
        let dictionary: [String : String] = [
            Test.TestNames.pupilResponse : Test.TestNames.pupilResponse,
            Test.TestNames.fallingToy : Test.TestNames.fallingToy,
            Test.TestNames.letsCrawl : Test.TestNames.letsCrawl,
            Test.TestNames.pointFollowing : Test.TestNames.pointFollowing,
            Test.TestNames.hearing : Test.TestNames.hearing,
            Test.TestNames.crossingEyes : Test.TestNames.crossingEyes,
            Test.TestNames.attentionAtDistance : Test.TestNames.attentionAtDistance,
            Test.TestNames.symmetry : Test.TestNames.symmetry,
            Test.TestNames.pincer : Test.TestNames.pincer,
            Test.TestNames.partiallyCoveredToy : Test.TestNames.partiallyCoveredToy,
            Test.TestNames.completelyCoveredToy : Test.TestNames.completelyCoveredToy,
            Test.TestNames.selfRecognition : Test.TestNames.selfRecognition,
            Test.TestNames.socialSmiling : Test.TestNames.socialSmiling,
            Test.TestNames.FacialMimic : Test.TestNames.FacialMimic,
            Test.TestNames.unassistedSitting : Test.TestNames.unassistedSitting,
            Test.TestNames.sittingAndReaching : Test.TestNames.sittingAndReaching,
            Test.TestNames.plasticJar : Test.TestNames.plasticJar
            // TODO: if new tests are added to the app, add them here.
        ]
        
        for (key, testName) in dictionary {
            var testHist = TestHistory()
            histories[testName] = testHist
        }
    }
    
    /*!
        @brief Initialize the TestHistories instance from the persistent store at filePath.
        @dicsussion Returns a valid object initialized to default values if no previous persisted instance exists.
        @return true if successfully initialized from a previously persisted instance, else false if no previous instance existed.
    */
    func initHistoriesFromPersistentStore() -> Bool {
        initHistories()
        
        if let unarchivedTestHistories = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath) as? [String: TestHistory] {
            self.histories = unarchivedTestHistories
            // DEBUG: printHistories()
            return true
        } else {
            return false
        }
    }
    
    /*!
        @brief Get the Test object for the specified test from this TiestHistories instance.
        @dicsussion Returns a Test object initialized from the current in-memory test data.
        @param testName (in) is the name of the test. Must be one of Test.TestNames.
        @return Test instance.
    */
    func getTest(testName:String) -> Test {
        var test = Test(testHistory: histories[testName]!)
        return test
    }
    
    /*! 
        @brief Update the most recent test result of a particular test in the test history.
        @dicsussion This function automatically updates the test date to the current date & time, and updates the test counters.
        @param testName (in) is the name of the test. Must be one of Test.TestNames.
        @param testResult (in) is the result of the test that the caller wishes to apply to the test hsitory.
        @return true if the test result was successfully updated, else false if an error occurred.
    */
    func addTestResult(testName name:String?, testResult result: Bool?) -> Bool {

        if let name = name, result = result {
            var testDict = histories[name]
            if let history = testDict {
                
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
            }
            return true
        } else {
            return false
        }
    }
    
    /*!
    @brief Get a TestHistory object identified by testName from this object's collection of test histories.
    @param testName (in) The name of the test whose history is being requested. Must be of Test.TestNames. (cannot be nil)
    @return The requested TestHistory object. If the TestHistory object cannot be acquired, return a default TestHistory object.
    */
    func getTestHistory(testName name:String) -> TestHistory {
        if let history = histories[name] {
            return history
        } else {
            return TestHistory()
        }
    }
    
    /*!
        @brief Write the histories for all tests to the persistant data store.
        @return true if successfully persisted, else false if an error occurred.
    */
    func save() -> Bool {
        return NSKeyedArchiver.archiveRootObject(self.histories, toFile: self.filePath)
    }
    
    /*
        @brief Identifies if most recent test succeeded.
        @discussion Will return false if there is a successful test but it was not the most recent test.
        @param testName (in) is the name of the test. Must be a value in Test.TestNames. Cannot be nil.
        @return true if most recent test result succeeded and number of successful tests > 0, else returns false.
    */
    func succeeded(testName name:String) -> Bool {
        if let testHistory: TestHistory = histories[name] {
            if testHistory.countOfSuccessfulTests > 0 && testHistory.mostRecentTestResult == true {
                return true
            }
        }
        return false
    }
    
    /*
        @brief Identifies if the test has succeeded at least once.
        @discussion Will return true if there is a successful test but it was not the most recent test.
        @param testName (in) is the name of the test. Must ve a value in Test.TestNames. Cannot be nil.
        @return true if number of successful tests > 0, else returns false.
    */
    func everSucceeded(testName name:String) -> Bool {
        if let testHistory: TestHistory = histories[name] {
            if testHistory.countOfSuccessfulTests > 0 {
                return true
            }
        }
        return false
    }

    /*
        @brief Get the number of tests that have been run for the specified testName.
        @discussion Will return 0 if their is no history for the specified testName.
        @param testName (in) is the name of the test. Must ve a value in Test.TestNames. Cannot be nil.
        @return The number of completed tests.
    */
    func testCount(testName name:String) -> Int {
        if let testHistory: TestHistory = histories[name] {
            return testHistory.countOfCompletedTests
        } else {
            return 0
        }
    }
    
    /*
        @brief Get the number of failed tests for the specified testName.
        @discussion Will return 0 if their is no history for the specified testName.
        @param testName (in) is the name of the test. Must ve a value in Test.TestNames. Cannot be nil.
        @return The number of failed tests.
    */
    func failedTestsCount(testName name:String) -> Int {
        if let testHistory: TestHistory = histories[name] {
            return testHistory.countOfFailedTests
        } else {
            return 0
        }
    }
    
    /*
        @brief Print out the contents of the histories dictionary to the console
        @discussion This method is intended for use in development releases only. It is not intended for use in production releases.
    */
    func printHistories() {
        
        for (testName, testDictionary) in histories {
            println("\t\t\(testName):")
            println("\t\t\t mostRecentTestDate     \t \(testDictionary.mostRecentTestDate))")
            println("\t\t\t mostRecentTestResult   \t \(testDictionary.mostRecentTestResult)")
            println("\t\t\t countOfFailedTests     \t \(testDictionary.countOfFailedTests)")
            println("\t\t\t countOfSuccessfulTests \t \(testDictionary.countOfSuccessfulTests)")
            println("\t\t\t countOfCompletedTests  \t \(testDictionary.countOfCompletedTests)")
            println("")
        }
    }
    
    // MARK: NSCoding
    
    required init(coder unarchiver: NSCoder) {
        super.init()
        decodeWithCoder(coder: unarchiver)
    }
    
    /*!
        @brief Set instance properties to values read from persistent store.
        @dicsussion Will set an instance property to it's default value if the corresponding NSUnarchiver key does not exist.
        @param dictionary (in) The NSUnarchiver object identifying the persistent store from which to read the property values.
    */
    func decodeWithCoder(coder decoder: NSCoder) {
        
        // returns nil if key does not exist, or if value is nil
        if let testHistories = decoder.decodeObjectForKey("testHistories") as! [String : TestHistory]? {
            self.histories = testHistories
        } else {
            self.histories = [String : TestHistory]()
        }
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(self.histories, forKey: "testHistories")
    }
}