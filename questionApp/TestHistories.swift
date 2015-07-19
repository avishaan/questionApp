/*!
    @header TestHistories.swift

    @brief This file contains the TestHistories class which manages a dictionary of TestHistory instances. Methods are available to record and query test results for individual tests. All test histories are persisted by this class.
    
    Created on 7/19/15

    @author John Bateman

    @copyright 2015 Qidza, Inc.
*/

import Foundation

class TestHistories {
    
    // key = name of the test. (See self.TestNames struct for a valid list of names.)
    // value = a TestHistory object
    var histories = [String : TestHistory]()
    
    /*
    Archive data structure
    
    // The archive is a dictionary,
    // where key is a String identifying a test name,
    // and where the value is a TestHistory dictionary.
    
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
        static var expressionMimic: String = "expression mimic"
    }
    
    /** Computed property for the path to the file where the data is persisted. */
    var filePath : String {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
        return url.URLByAppendingPathComponent(self.archiveFilename).path!
    }
    
    init() {
        initHistories()
    }
    
    /*!
    @brief Initialize the TestHistories instance setting all test histories to default values.
    */
    func initHistories() {
        
        let dictionary: [String : String] = [
            TestHistories.TestNames.pupilResponse : TestHistories.TestNames.pupilResponse,
            TestHistories.TestNames.fallingToy : TestHistories.TestNames.fallingToy,
            TestHistories.TestNames.pointFollowing : TestHistories.TestNames.pointFollowing,
            TestHistories.TestNames.letsCrawl : TestHistories.TestNames.letsCrawl,
            TestHistories.TestNames.hearing : TestHistories.TestNames.hearing,
            TestHistories.TestNames.crossingEyes : TestHistories.TestNames.crossingEyes,
            TestHistories.TestNames.attentionAtDistance : TestHistories.TestNames.attentionAtDistance,
            TestHistories.TestNames.symmetry : TestHistories.TestNames.symmetry
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
            printHistories()
            return true
        } else {
            return false
        }
    }
    
    /*!
    @brief Update the most recent test result of a particular test in the test history.
    @dicsussion This function automatically updates the test date to the current date & time, and updates the test counters.
    @param testName (in) is the name of the test. Must be one of Testnames.
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
    @brief Write the histories for all tests to the persistant data store.
    @param testResult (in) is the result of the test that the caller wishes to apply to the test hsitory.
    @return true if successfully persisted, else false if an error occurred.
    */
    func save() -> Bool {
        return NSKeyedArchiver.archiveRootObject(self.histories, toFile: self.filePath)
    }
    
    /*
    @brief Identifies if most recent test succeeded.
    @discussion Will return false if there is a successful test but it was not the most recent test.
    @param testName (in) is the name of the test. Must ve a value in self.TestNames. Cannot be nil.
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
    @param testName (in) is the name of the test. Must ve a value in self.TestNames. Cannot be nil.
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
    @param testName (in) is the name of the test. Must ve a value in self.TestNames. Cannot be nil.
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
    @param testName (in) is the name of the test. Must ve a value in self.TestNames. Cannot be nil.
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
            println("\(testName):")
            println("mostRecentTestDate     \t \(testDictionary.mostRecentTestDate))")
            println("mostRecentTestResult   \t \(testDictionary.mostRecentTestResult)")
            println("countOfFailedTests     \t \(testDictionary.countOfFailedTests)")
            println("countOfSuccessfulTests \t \(testDictionary.countOfSuccessfulTests)")
            println("countOfCompletedTests      \t \(testDictionary.countOfCompletedTests)")
            println("")
        }
    }
}