/*!
@header TestMonitor.swift

@brief This file contains the TestMonitor class which observes test related notifications.
@discussion Persistence: This class should be instantiated early in the application's lifecycle to ensure events are not missed.

Created on 8/21/15

@author John Bateman

@copyright 2015 Qidza, Inc.
*/

import Foundation

class TestMonitor: NSObject {
    
    override init() {
        super.init()
        addReminderObservers()
    }
    
    deinit {
        removeReminderObservers()
    }
    
    /* Add observers for the reminder notifications */
    func addReminderObservers() {
        // Add a notification observer for scheduled reminders.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTestReminderScheduled:", name: testReminderScheduledNotificationKey, object: nil)
        //Add a notification observer for removed reminders.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTestReminderRemoved:", name: testReminderRemovedNotificationKey, object: nil)
    }
    
    /* Remove observers for the reminder notifications */
    func removeReminderObservers() {
        // Remove observer for the scheduled reminder notification.
        NSNotificationCenter.defaultCenter().removeObserver(self, name: testReminderScheduledNotificationKey, object: nil)
        // Remove observer for the removed reminder notification.
        NSNotificationCenter.defaultCenter().removeObserver(self, name: testReminderRemovedNotificationKey, object: nil)
    }
    
    /* 
    @brief Listen for the testReminderScheduledNotificationKey notification, extract the test name from the notification's userInfo, and set the testHistory reminderDate property to the current date.
    */
    func onTestReminderScheduled(notification: NSNotification) {
        if let testName = notification.userInfo![testNameUserInfoKey] as? String {
            // get histories for the current profile
            var parent = Parent()
            var profiles = TestProfiles()
            profiles.initProfilesFromPersistentStore()
            var histories = profiles.getTestHistories(profileName: parent.getCurrentProfileName())
            if let histories = histories {
                let testHistory = histories.getTestHistory(testName: testName)
                // set the reminder date
                testHistory.reminderDate = NSDate()
                profiles.save() // persist updated testHistory properties
            }
        }
    }
    
    /*
    @brief Listen for the testReminderRemovedNotificationKey notification, extract the test name from the notification's userInfo, and set the testHistory reminderDate property to nil.
    */
    func onTestReminderRemoved(notification: NSNotification) {
        if let testName = notification.userInfo![testNameUserInfoKey] as? String {
            // get histories for the current profile
            var parent = Parent()
            var profiles = TestProfiles()
            profiles.initProfilesFromPersistentStore()
            var histories = profiles.getTestHistories(profileName: parent.getCurrentProfileName())
            if let histories = histories {
                let testHistory = histories.getTestHistory(testName: testName)
                // set the reminder date
                testHistory.reminderDate = nil
                profiles.save() // persist updated testHistory properties
            }
        }
    }
}