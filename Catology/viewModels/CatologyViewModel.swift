//
//  CatologyViewModel.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/10/24.
//

import Combine

protocol CatologyViewModelType: ObservableObject {
    var contentModel: [CatologyContentModel] { get }
    var presentedIndex: Int { get }
    
    func performScreenClickAction()
}

extension CatologyViewModelType {
    var nextFact: String? { contentModel[safe: presentedIndex]?.fact }
    var nextImageURL: String? { contentModel[safe: presentedIndex]?.url }
}

class CatologyViewModel {
    private var cancellables = Set<AnyCancellable>()
    private let serviceProvider: CatologyFactsServiceProviderType
    
    @Published private(set) var contentModel: [CatologyContentModel] = []
    @Published private(set) var error: CatologyFactsRequestError.Model? = nil
    
    @Published private(set) var presentedIndex: Int = 0
    
    @Published private(set) var isLoading: Bool = false
    
    init(service: CatologyFactsServiceProviderType = CatologyFactsProviderService()) {
        self.serviceProvider = service
    }
}

private extension CatologyViewModel {
    func receiveCompletion(result: Subscribers.Completion<CatologyFactsRequestError>) {
        if case let .failure(failure) = result {
            self.error = failure.model
            print("Error: \(failure.model.message)")
        }
        self.isLoading = false
    }
    
    func receive(content models: [CatologyContentModel]) {
        contentModel.append(contentsOf: models)
        isLoading = false
        guard presentedIndex != .zero else { return }
        presentedIndex++
    }
    
    func fetchNewContent() {
        isLoading = false
        Publishers.Zip(
            self.serviceProvider.fetchRandomFacts(),
            self.serviceProvider.fetchRandomImage()
        ).compactMap {
            zip($0.0, $0.1).map { $0.1.set(fact: $0.0) }
        }.sink(
            receiveCompletion: receiveCompletion,
            receiveValue: receive(content:)
        ).store(in: &cancellables)
    }
}

extension CatologyViewModel: CatologyViewModelType {
    func performScreenClickAction() {
        if (contentModel.count - presentedIndex) <= 4 {
            if (contentModel.count - presentedIndex) <= 1 {
                isLoading = true
            }
            self.fetchNewContent()
        } else {
            presentedIndex++
        }
    }
}
