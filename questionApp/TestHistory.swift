/*!
    @header TestHistory.swift

    @brief This file contains the TestHistory class which contains information about test results saved for the test. The class conforms to NSCoding protocol and can therefor persist it's properties.

    Created on 7/16/15

    @author John Bateman

    @copyright 2015 Qidza, Inc.
*/

import Foundation

class TestHistory: NSObject, NSCoding {
    
    // Keys used for NSKeyeArchiver, NSKeyedUnarchiver, and the convenience initializer.
    struct Keys {
        static let mostRecentTestDate: String = "mostRecentTestDate"
        static let mostRecentTestResult: String = "mostRecentTestResult"
        static let countOfFailedTests: String = "countOfFailedTests"
        static let countOfSuccessfulTests: String = "countOfSuccessfulTests"
        static let countOfCompletedTests: String = "countOfCompletedTests"
        static let succeededTestDate: String = "succeededTestDate"
        static let reminderDate: String = "reminderDate"
    }
    
    // MARK: Properties
    var mostRecentTestDate = NSDate()
    var mostRecentTestResult = false
    var countOfFailedTests: Int = 0
    var countOfSuccessfulTests = 0
    var countOfCompletedTests = 0
    var succeededTestDate: NSDate? = nil
    var reminderDate: NSDate? = nil
    
    // Initializes object with default values
    override init() {
        super.init()
    }
    
    /*!
    @brief Initialize the instance with a dictionary of properties.
    @dicsussion All properties are initialized to their default values if not specified in the dictionary.
    @param dictionary (in) A dictionary where key is a Keys struct value (example. Keys.mostRecentTestDate), and where value is the desired initial value for the associated property.
    */
    convenience init(dictionary: [String : AnyObject]) {
        self.init()
        
        if let date = dictionary[Keys.mostRecentTestDate] as? NSDate {
            mostRecentTestDate = date
        }
        if let result = dictionary[Keys.mostRecentTestResult] as? Bool {
            mostRecentTestResult = result
        }
        if let failed = dictionary[Keys.countOfFailedTests] as? Int {
            countOfFailedTests = failed
        }
        if let success = dictionary[Keys.countOfFailedTests] as? Int {
            countOfSuccessfulTests = success
        }
        if let total = dictionary[Keys.countOfFailedTests] as? Int {
            countOfCompletedTests = total
        }
        if let successDate = dictionary[Keys.succeededTestDate] as? NSDate {
            succeededTestDate = successDate
        }
        if let reminder = dictionary[Keys.reminderDate] as? NSDate {
            reminderDate = reminder
        }
    }
    
    func print() {
        println("date: \(mostRecentTestDate),  result: \(mostRecentTestResult), failed: \(countOfFailedTests), successful: \(countOfSuccessfulTests), completed: \(countOfCompletedTests), succeeded date: \(succeededTestDate), reminder date: \(reminderDate)")
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
        if let date = decoder.decodeObjectForKey(Keys.mostRecentTestDate) as? NSDate {
            mostRecentTestDate = date
        } else {
            mostRecentTestDate = NSDate()
        }
        
        // returns false if key doesn't exist, which is the correct default value
        mostRecentTestResult = decoder.decodeBoolForKey(Keys.mostRecentTestResult)
        
        // returns 0 if key doesn't exist, which is the correct default value
        countOfFailedTests = Int(decoder.decodeIntForKey(Keys.countOfFailedTests))
        countOfSuccessfulTests = Int(decoder.decodeIntForKey(Keys.countOfSuccessfulTests))
        countOfCompletedTests = Int(decoder.decodeIntForKey(Keys.countOfCompletedTests))
        
        // returns nil if key does not exist, or if value is nil
        if let successDate = decoder.decodeObjectForKey(Keys.succeededTestDate) as? NSDate {
            succeededTestDate = successDate
        } else {
            succeededTestDate = nil
        }
        
        // returns nil if key does not exist, or if value is nil
        if let reminder = decoder.decodeObjectForKey(Keys.reminderDate) as? NSDate {
            reminderDate = reminder
        } else {
            reminderDate = nil
        }
    }
    
    /*!
    @brief Write instance properties to the persistent store.
    @param encoder (in) The NSUnarchiver object identifying the persistent store to which to wirte the property values.
    */
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(mostRecentTestDate, forKey: Keys.mostRecentTestDate)
        encoder.encodeBool(mostRecentTestResult, forKey: Keys.mostRecentTestResult)
        encoder.encodeInteger(countOfFailedTests, forKey: Keys.countOfFailedTests)
        encoder.encodeInteger(countOfSuccessfulTests, forKey: Keys.countOfSuccessfulTests)
        encoder.encodeInteger(countOfCompletedTests, forKey: Keys.countOfCompletedTests)
        encoder.encodeObject(succeededTestDate, forKey: Keys.succeededTestDate)
        encoder.encodeObject(reminderDate, forKey: Keys.succeededTestDate)
    }
}
