//
//  RealmRepositoryTests.swift
//  TinderSwipeCardsTests
//
//  Created by Huy Quang Nguyen on 11/25/20.
//

import XCTest
import RealmSwift
@testable import TinderSwipeCards

class RealmRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInsertPerson() {
        let personObject = PersonObject(fullName: "FullName", birthday: "22/04/1990", address: "Ho Chi Minh city", phoneNumber: "9999 9999 999", password: "abc-123", picturePath: "picturePath")
        let repository = createRepository()
        
        try! repository.insert(item: personObject)
        let savedItems: [PersonObject] = repository.getAll()
        
        XCTAssertEqual(1, savedItems.count)
    }

    func testUpdatePerson() {
        var personObject = PersonObject(fullName: "FullName", birthday: "22/04/1990", address: "Ho Chi Minh city", phoneNumber: "9999 9999 999", password: "abc-123", picturePath: "picturePath")
        let repository = createRepository()
        try! repository.insert(item: personObject)

        // Update person object
        personObject.fullName = "Updated FullName"

        try! repository.update(item: personObject)

        let savedItems: [PersonObject] = repository.getAll()

        XCTAssertEqual("Updated FullName", savedItems.first!.fullName)
    }
    
    func testDeletePerson() {
        let personObject = PersonObject(fullName: "FullName", birthday: "22/04/1990", address: "Ho Chi Minh city", phoneNumber: "9999 9999 999", password: "abc-123", picturePath: "picturePath")
        let repository = createRepository()
        try! repository.insert(item: personObject)

        try! repository.delete(item: personObject)

        let savedItems: [PersonObject] = repository.getAll()

        XCTAssertEqual(0, savedItems.count)
    }

    func test_getAllPeopleWithFilter() {
        let personObject1 = PersonObject(fullName: "FullName1", birthday: "22/04/1990", address: "Ho Chi Minh city", phoneNumber: "9999 9999 999", password: "abc-123", picturePath: "picturePath")

        let personObject2 = PersonObject(fullName: "FullName2", birthday: "22/04/1990", address: "Ho Chi Minh city", phoneNumber: "888888888", password: "abc-123", picturePath: "picturePath")
        let repository = createRepository()
        try! repository.insert(item: personObject1)
        try! repository.insert(item: personObject2)

        let savedItems: [PersonObject] = repository.getAll(where: NSPredicate(format: "fullName = %@", personObject2.fullName))

        XCTAssertEqual(1, savedItems.count)
    }

    private func createRepository() -> AnyRepository<PersonObject> {
        return AnyRepository()
    }

}
