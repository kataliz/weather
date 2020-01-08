//
//  Observable+helpers.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol OptionalType {
    associatedtype Wrapped
    
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

extension Observable where Element: OptionalType {
    func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}

extension Observable {
    func first() -> Observable {
        return take(1)
    }
    
    func toNever() -> Observable<Void> {
        return flatMap { _ -> Observable<Void> in return .never() }
    }
    
    func toVoid() -> Observable<Void> {
        return map { _ -> Void in
            return ()
        }
    }
}

extension ObservableType {
    func flatMap<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
        return flatMap { [weak obj] value -> Observable<O.Element> in
            try obj.map { try selector($0, value).asObservable() } ?? .empty()
        }
    }
    
    func flatMapLatest<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
        return flatMapLatest { [weak obj] value -> Observable<O.Element> in
            try obj.map { try selector($0, value).asObservable() } ?? .empty()
        }
    }
    
    func flatMapFirst<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
        return flatMapFirst { [weak obj] value -> Observable<O.Element> in
            try obj.map { try selector($0, value).asObservable() } ?? .empty()
        }
    }
    
    func wrapAsObservable() -> Observable<Observable<Self.Element>> {
        return Observable.just(self.asObservable())
    }
    
    func filterOn<T>(_ observable: Observable<T>, selector: @escaping (Element, T) -> Bool) -> Observable<Element> {
        return withLatestFrom(observable) { ($0, $1) }.filter(selector).map( { $0.0 })
    }
}

extension Reactive where Base: UIViewController {
    var viewDidAppear: Observable<Void> {
        return self.sentMessage(#selector(Base.viewDidAppear(_:))).map { _ in Void() }
    }
    
    var viewWillAppear: Observable<Void> {
        return self.sentMessage(#selector(Base.viewWillAppear(_:))).map { _ in Void() }
    }
}

extension Reactive where Base: UIRefreshControl {
    var delayedTriggered: Observable<Void> {
        return controlEvent(.valueChanged).asObservable().delay(DispatchTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
    }
}

extension Reactive where Base: DayDetailedView {
    var detailedList: Binder<[DayDetailedCellInfo]> {
        return Binder(self.base, scheduler: MainScheduler.instance) { (target, value) in
            target.detailedList = value
        }
    }
}

