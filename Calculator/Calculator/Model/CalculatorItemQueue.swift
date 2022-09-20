//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by leewonseok on 2022/09/20.
//

import Foundation

struct CalculatorItemQueue {
    
}

class Node<T> {
    var data: T?
    var next: Node?
    
    init(data: T?, next: Node? = nil) {
        // 노드 생성시 data 값과 다음 Node에 대한 값
        // 다음 Node에 대한 값을 받는 경우는 중간에 삽입하는 경우일 듯?
        self.data = data
        self.next = next
    }
}

class LinkedList<T: Equatable> {
    // 첫번째 노드를 가르키는 변수 head
    private var head: Node<T>?
    
    func append(data: T?) {
        if head == nil {
            head = Node(data: data)
            return
        }
        var node = head
        while node?.next != nil {
            node = node?.next
        }
        node?.next = Node(data: data)
    }
    // 얘 필요없을거같은ㄷ
    func insert(data: T?, at index: Int) {
        
        //head가 없는 경우 Node를 생성 후 head로 지정한다
        if head == nil {
            head = Node(data: data)
            return
        }
        
        var node = head
        for _ in 0..<(index - 1) {
            if node?.next == nil { break }
            node = node?.next
        }
        
        let nextNode = node?.next
        node?.next = Node(data: data)
        node?.next?.next = nextNode
        
    }
    

   func removeLast() {
       
       if head == nil { return }
       
    // head를 삭제하는 경우
       if head?.next == nil {
           head = nil
           return
       }
       
       var node = head
       while node?.next?.next != nil {
           node = node?.next
       }
       
       node?.next = node?.next?.next
       
   }
    
    func remove(at index: Int) {
        
        if head == nil { return }
        
        // head를 삭제하는 경우
        if index == 0 || head?.next == nil {
            head = head?.next
            return
        }
        
        var node = head
        for _ in 0..<(index - 1) {
            if node?.next?.next == nil { break }
            node = node?.next
        }
        
        node?.next = node?.next?.next
        
    }
     

    func searchNode(from data: T?) -> Node<T>? {
        
        if head == nil { return nil }
        
        var node = head
        while node?.next != nil {
            if node?.data == data { break; }
            node = node?.next
        }
        
        return node
    }

}
