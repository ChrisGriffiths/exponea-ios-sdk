//
//  MockFetchRepository.swift
//  ExponeaSDKTests
//
//  Created by Ricardo Tokashiki on 20/04/2018.
//  Copyright © 2018 Exponea. All rights reserved.
//

import Foundation

@testable import ExponeaSDK

class MockFetchRepository: FetchRepository {

    var configuration: Configuration

    init(configuration: Configuration) {
        self.configuration = configuration
    }

    func fetchProperty(projectToken: String, customerId: KeyValueItem, property: String) {
        return
    }

    func fetchId(projectToken: String, customerId: KeyValueItem, id: String) {
        return
    }

    func fetchSegmentation(projectToken: String, customerId: KeyValueItem, id: String) {
        return
    }

    func fetchExpression(projectToken: String, customerId: KeyValueItem, id: String) {
        return
    }

    func fetchPrediction(projectToken: String, customerId: KeyValueItem, id: String) {
        return
    }

    func fetchRecommendation(projectToken: String,
                             customerId: KeyValueItem,
                             recommendation: CustomerRecommendation,
                             completion: @escaping (Result<Recommendation>) -> Void) {

        let router = RequestFactory(baseURL: configuration.baseURL,
                               projectToken: projectToken,
                               route: .customersRecommendation)
        let customersParams = CustomerParameters(customer: customerId,
                                              property: nil,
                                              id: nil,
                                              recommendation: recommendation,
                                              attributes: nil,
                                              events: nil,
                                              data: nil)
        let request = router.prepareRequest(authorization: configuration.authorization,
                                            trackingParam: nil, customersParam: customersParams)
        let bundle = Bundle(for: type(of: self))

        guard request.url != nil else {
            fatalError("URL could not be retrieve")
        }

        guard
            let file = bundle.url(forResource: "get-recommendation", withExtension: "json"),
            let data = try? Data(contentsOf: file),
            let recommendation = try? JSONDecoder().decode(Recommendation.self, from: data)
            else {
                fatalError("Something is horribly wrong with the data.")
        }

        let result = Result.success(recommendation)

        completion(result)
    }

    func fetchAttributes(projectToken: String, customerId: KeyValueItem, attributes: [CustomerAttributes]) {
        return
    }

    func fetchEvents(projectToken: String,
                     customerId: KeyValueItem,
                     events: FetchEventsRequest,
                     completion: @escaping (Result<FetchEventsResponse>) -> Void) {
        return
    }

    func fetchAllProperties(projectToken: String, customerId: KeyValueItem) {
        return
    }

    func fetchAllCustomers(projectToken: String, data: CustomerExportModel) {
        return
    }

    func anonymize(projectToken: String, customerId: KeyValueItem) {
        return
    }

}

extension MockFetchRepository: ConnectionManagerType {
    func trackCustomer(projectToken: String,
                       customerId: KeyValueItem,
                       properties: [KeyValueItem]) {
        return
    }

    func trackEvents(projectToken: String,
                     customerId: KeyValueItem,
                     properties: [KeyValueItem],
                     timestamp: Double?,
                     eventType: String?) {
        return
    }

    func rotateToken(projectToken: String) {
        return
    }
    func revokeToken(projectToken: String) {
        return
    }
}