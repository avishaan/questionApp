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
                "succeededTestDate" : NSDate()
                "reminderDate:" : NSDate()
            ]
         "hearing":
            [
                "mostRecentTestDate" : NSDate()
                "mostRecentTestResult" : true
                "countOfFailedTests" : 0
                "countOfSuccessfulTests" : 1
                "countOfCompletedTests" : 1
                "succeededTestDate" : NSDate()
                "reminderDate:" : NSDate()
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
            Test.TestNames.facialMimic : Test.TestNames.facialMimic,
            Test.TestNames.unassistedSitting : Test.TestNames.unassistedSitting,
            Test.TestNames.sittingAndReaching : Test.TestNames.sittingAndReaching,
            Test.TestNames.plasticJar : Test.TestNames.plasticJar,
            Test.TestNames.bookPresentation : Test.TestNames.bookPresentation
            // TODO: if new tests are added to the app, add them here.
        ]
        
        for (key, testName) in dictionary {
            var testHist = TestHistory(nameOfTest: testName)
            histories[testName] = testHist
        }
    }
    
    /*!
        @brief Initialize the TestHistories instance from the persistent store at filePath.
        @discussion Returns a valid object initialized to default values if no previous persisted instance exists.
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
        @brief Get the Test object for the specified test from this TestHistories instance.
        @discussion Returns a Test object initialized from the current in-memory test data.
        @param testName (in) is the name of the test. Must be one of Test.TestNames.
        @return Test instance.
    */
    func getTest(testName:String) -> Test {
        var test = Test(testHistory: histories[testName]!)
        return test
    }
    
    /*!
    @brief Get the next test that the user should run.
    @discussion The next test is a test that has not been successfully completed, (countOfSuccessfulTests = 0). More specifically it has not been run (countOfCompletedTests = 0). Or, if all tests have been run it has only failed (countOfCompletedTests > 0 AND countOfFailedTests > 0 AND countOfSuccessfulTests = 0).
    @return A Test object. If all tests have been completed successfully then return nil.
    */
    func getNextTest() -> Test? {
        var nextTest : Test?
        var totalNumberOfTests = histories.count
        
        /* The count of all tests that the user has run. */
        var countOfTestsRun = 0
        
        /* The count of all tests where countOfSuccessfulTests > 0 for an individual test. */
        var countOfTestsPassed = 0
        
        // count the number of tests that have been run and passed.
        for (testName, testHistory) in histories {
            // count the tests that have been run
            if testHistory.countOfCompletedTests > 0 {
                countOfTestsRun += 1
            }
            // count the tests that have passed
            if testHistory.countOfSuccessfulTests > 0 {
                countOfTestsPassed += 1
            }
        }
        
        // Order the histories key,value tuples into an array that is ordered to reflect the order an end user sees the tests in the UI.
        let orderedHistories = getOrderedHistories()
        
        // Find the next test.
        if countOfTestsRun < totalNumberOfTests {
            // Not all tests have been run. Find the first test not yet run.
            for history in orderedHistories {
                if history.countOfCompletedTests == 0 {
                    nextTest = Test(testHistory: history)
                    break
                }
            }
        } else if countOfTestsPassed < totalNumberOfTests {
            // Not all test have been passed (although all have been run). Find the first test not yet passed.
            for history in orderedHistories {
                if history.countOfSuccessfulTests == 0 {
                    nextTest = Test(testHistory: history)
                    break
                }
            }
        } else {
            // All tests have been run, and all have been passed.
            nextTest = nil
        }
        
        return nextTest
    }
    
    /* 
    @brief Get an ordered collection of TestHistory objects in the order that tests appear in the UI. 
    @return An array of TestHistory objects in the order that the tests appear in the UI.
    */
    func getOrderedHistories() -> [TestHistory] {
        var orderedHistories = [TestHistory]()
        for testName in Test.testsInPresentedOrder {
            let history = self.getTestHistory(testName: testName)
            orderedHistories.append(history)
        }
        return orderedHistories
    }
    
    /*!
        @brief Update the most recent test result of a particular test in the test history.
        @discussion This function automatically updates the test date to the current date & time, and updates the test counters.
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
            return TestHistory(nameOfTest: name)
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
  
  func successByCategory() -> [String:(Int, Int)] {
    var sensoryAndMotor:(success:Int, everSuccess:Int) = (0,0)
    var socialAndEmotional:(success:Int, everSuccess:Int) = (0,0)
    var languageAndCognitive:(success:Int, everSuccess:Int) = (0,0)
    
    // aggregate the results by category
    for testName in Test.TestNamesByCategory.sensoryAndMotor {
      if self.succeeded(testName: testName) {
        sensoryAndMotor.success += 1
      }
      if self.everSucceeded(testName: testName) {
        sensoryAndMotor.success += 1
      }
    }
    for testName in Test.TestNamesByCategory.socialAndEmotional {
      if self.succeeded(testName: testName) {
        socialAndEmotional.success += 1
      }
      if self.everSucceeded(testName: testName) {
        socialAndEmotional.success += 1
      }
    }
    for testName in Test.TestNamesByCategory.languageAndCognitive {
      if self.succeeded(testName: testName) {
        languageAndCognitive.success += 1
      }
      if self.everSucceeded(testName: testName) {
        languageAndCognitive.success += 1
      }
    }
    
    return [
      Test.CategoryNames.sensoryAndMotor:sensoryAndMotor,
      Test.CategoryNames.socialAndEmotional:socialAndEmotional,
      Test.CategoryNames.languageAndCognitive:languageAndCognitive,
    ]
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
    @brief Get the names of all the tests that have not yet been passed.
    @discussion A test will be included in the list only if it has never passed.
    @return An array of Strings, where each String is the name of a test. The names are Test.TestNamesPresentable values. The array may be empty.
    */
    func neverPassed() -> [String] {
        var neverPassed = [String]()
        
        for (testName, testHistory) in histories {
            if testHistory.countOfSuccessfulTests == 0 {
                neverPassed.append(testName)
            }
        }
        
        return neverPassed
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
  
    /*
        :brief Return the number of total tests passed so far
        :discussion this method allows use to answer the question "how many tests app wide have passed at some point?"
    */
  
  var numSuccessful:Int {
    
    get {
      
      var successful = 0
      
      for (testName, testDictionary) in histories {
        successful += testDictionary.countOfSuccessfulTests
      }
      return successful
    }
  }
  
    
    // MARK: NSCoding
    
    required init(coder unarchiver: NSCoder) {
        super.init()
        decodeWithCoder(coder: unarchiver)
    }
    
    /*!
        @brief Set instance properties to values read from persistent store.
        @discussion Will set an instance property to it's default value if the corresponding NSUnarchiver key does not exist.
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
    
    // TODO: This is a test function added 8/18/2015 to exercise the NeverPassed function and demonstrate its usage. Remove it.
    // For the current profile it dumps a list of tests that have never been passed to the console.
//    static func testTheNeverPassedFunction() {
//        var parent = Parent()
//        var profiles = TestProfiles()
//        profiles.initProfilesFromPersistentStore()
//        
//        if let testHistories = profiles.getTestHistories(profileName: parent.getCurrentProfileName()) {
//            var neverPassedList = testHistories.neverPassed()
//            for name in neverPassedList {
//                println("\(name)")
//            }
//        }
//    }

    // MARK: Reminders
    
    // TODO: The functions in this section are to support tracking of reminders. When reminders are scheduled the testReminderScheduledNotificationKey is fired. When reminders are removed the testReminderRemovedNotificationKey notification is fired. An object in the app can listen for these events and update the list of reminders displayed in the MilestonesViewController. The object needs to be instantiated early in the lifecycle of the app so that it is around when the above reminder notifcations are fired.
    
    /* 
    @brief Get a list of Test objects for which reminders are currently scheduled.
    @discussion Reminders are local notifications.
    @return An array of Test objects. The returned array may be empty if no reminders are currently scheduled.
    */
    func getTestsWithReminders() -> [Test] {
        var testsWithReminders = [Test]()
        for (testName, history) in histories {
            if history.reminderDate != nil {
                let test = Test(testHistory: history)
                testsWithReminders.append(test)
            }
        }
        return testsWithReminders
    }
    
    func countTestsWithReminders() -> Int {
        var count = 0
        for (testName, history) in histories {
            if history.reminderDate != nil {
                count += 1
            }
        }
        return count
    }
    
    func testgetTestsWithReminders() {
        // get histories for the current profile
        var parent = Parent()
        var profiles = TestProfiles()
        profiles.initProfilesFromPersistentStore()
        var histories = profiles.getTestHistories(profileName: parent.getCurrentProfileName())
        let reminderedTests = getTestsWithReminders()
        println("tests with reminders:")
        for test in reminderedTests {
            println("\(test.history.testName)")
        }
    }
}