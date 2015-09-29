//
//  TestProfiles.swift
//  questionApp
//
//  Created by john bateman on 7/28/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation

//
//  TestProfiles.swift
//  MyArchiver
//
//  Created by john bateman on 7/27/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//

import Foundation

class TestProfiles {
    
    /*
    Archive data structure
    
        Instances of this class are persisted with the following structure (described below):

        [ String : [ String : TestHistory ] ]
                              |--- 3 ---|
                   |---------- 2 ---------|
        |---------------- 1 ----------------|
        
        1 - The archive is a dictionary where each top level key is a String identifying a child profile. Each value is a dictionary describing TestHistories for the profile (see 2).
        2 - Each dictionary key is a String identifying an individual test name. Each value contains a TestHistory.
        3 - A TestHistory is a dictionary of key:value pairs describing previous outcomes of a test.
        
        Example:
        
        [
         "michael":
            [
             "symmetry":
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
         "mary":
            [
                "symmetry":
                ...
            ]
         ...
        ]
    */
    var testProfiles = [String : TestHistories]()
    
    // The name of the file where the test profiles data is persisted.
    let archiveFilename = "TestProfilesArchive"
    
    /** Computed property for the path to the file where the data is persisted. */
    var filePath : String {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as NSURL!
        return url.URLByAppendingPathComponent(self.archiveFilename).path!
    }

    /*!
    @brief Persists all profiles to disk.
    @return true if successfully persisted, else false if an error occurred.
    */
    func save() -> Bool {
        return NSKeyedArchiver.archiveRootObject(self.testProfiles, toFile: self.filePath)
    }
    
    /*!
    @brief Initialize the TestProfiles instance from the persistent store at filePath.
    @dicsussion Returns a valid object initialized to default values if no previous persisted instance exists.
    @return true if successfully initialized from a previously persisted instance, else false if no previous instance existed.
    */
    func initProfilesFromPersistentStore() -> Bool {
        if let unarchivedTestProfiles = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath) as? [String:TestHistories] /*[TestProfile]*/ {
            self.testProfiles = unarchivedTestProfiles
            //printProfiles()
            return true
        } else {
            return false
        }
    }

    /*
    @brief Get a Test for the named profile and test.
    @param profileName (in) A Parent object. (cannot be nil)
    @param testName (in) The name of the test. Must be of Test.TestNames. (cannot be nil)
    @return Returns the requested Test object, else a default Test object if the named profile or test did not exist.
    */
    func getTest(profileName: String, testName: String) -> Test {
        // Get the test histories for the profile with the specified name.
        if let testHistories = testProfiles[profileName] {
            let test = testHistories.getTest(testName)
            return test
        } else {
            return Test()
        }
    }
    
    /*
    @brief Convenience function to create a profile name in the following format: "<parent_name>.<baby_name>"
    @discussion This format is recommended as it can support multiple parents and child profiles on the same device.
    @param parentName (in) The name of the parent. (cannot be nil)
    @param babyName (in) The name of the child. (cannot be nil)
    @return The concatenated profile name as a String.
    */
    func makeProfileName(parentName parentName: String, babyName: String) -> String {
        let profileName = "\(parentName).\(babyName)"
        return profileName
    }
    
    /*
    @brief create a TestProfile and add it to the testProfiles collection
    @discussion Creates a profile for name if it doesn't already exist. If it exists this function does nothing.
    */
    func addProfile(name name: String) {
        if testProfiles[name] == nil {
            // testProfiles doesn't contain a key by that name yet so add it.
            testProfiles[name] = TestHistories()
        }
    }
    
    // remove the TestProfile of the given name from the testProfiles collection
    func removeProfile(name: String) {
        testProfiles[name] = nil
    }
    
    // remove all profiles
    func removeAllProfiles() {
        testProfiles.removeAll(keepCapacity: false)
    }
    
    /*!
    @brief Get the TestHistories for a specified profile name.
    @return The TestHistories object for name. nil If no match is found.
    */
    func getTestHistories(profileName profileName: String) -> TestHistories? {
        return testProfiles[profileName]
    }
    
    /*!
    @brief Get a TestProfile by name.
    @return The TestProfile whose profileName property == name. If no match is found then returns nil.
    */
    func printProfiles() {
        for (profileName, testHistories) in testProfiles {
            print("{ ")
            print("\t\(profileName) : {")
            testHistories.printHistories()
            print("\t}")
            print(" }")
        }
    }
}