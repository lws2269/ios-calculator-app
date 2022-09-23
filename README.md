# **계산기 (calculator-app)*


## 목차
1. [소개](##1.**소개**)
2. [팀원]()
3. [실행 화면(기능 설명)]()
4. [UML]()
5. [트러블 슈팅]()
6. [고민한 부분]()
7. [참고 링크]()
## 1. **소개**
두개의 연산값을 연산하여 반환하는 계산기앱입니다. - **연산자 우선순위는 생각하지 않습니다.**


## 2. **🧑‍🤝‍🧑 팀원**

| **stone** | 
| ----- | 
| <img width="180px" src="https://avatars.githubusercontent.com/u/74972815?v=4"> | 


## 3. 👩🏻‍💻 실행 화면(기능 설명)
- 이후 추가

## 4. UML
![](https://i.imgur.com/DSzaMlT.png)

## 5. **🔥 트러블 슈팅**

### `CalculatorItemQueue`에서 빈`queue`에 `dqueue`메서드를 실행했을때, `index out of range`에러
- `headIndex`를 통하여 큐에 직접 접근하는 방식으로 구현하다 보니, 테스트 코드에서 빈`queue`값에 접근 시 `index out of range`에러가 발생하는 문제가 있었습니다.
- 이와 같은 에러를 해결하기 위해 아래같은 방식으로 접근했습니다.
```swift
mutating func dequeue() -> CalculateItem? {
    guard queue.count != 0, head <= queue.count, let element = queue[head] else { return nil }

    queue[headIndex] = nil
    headIndex += 1
    if headIndex > (queue.count / 4) {
        queue.removeFirst(headIndex)
        headIndex = 0
    }
    return element    
}
```
- 위 방식으로 구현했을 떄 문제점은, `queue.count != 0` 조건을 통해 빈`queue`에 접근했을시, nil을 반환하는 조건으로 체크할 수 있었지만, 안전하지 않아 보인다는 문제가 있었습니다.

- 문제를 개선하기 위해 아래 코드와 같이 `Array`타입을 확장해주어 서브스크립트로 빈값에 접근할시 nil을 반환하는 코드를 작성했습니다.
```Swift
extension Array {
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
```
- 위 코드를 통해 `queue.count != 0` 조건을 제거할 수 있었고, `queue[safe: headIndex]` 한 코드로 `queue` 에 대한 유효성 검사를 할 수 있었습니다.
```swift
mutating func dequeue() -> CalculateItem? {
    guard headIndex <= queue.count, let element = queue[safe: headIndex] else { return nil }

    queue[headIndex] = nil
    headIndex += 1
    if headIndex > (queue.count / 4) {
        queue.removeFirst(headIndex)
        headIndex = 0
    }
    return element
}
```
## 6. **🤔고민한 부분**

### 1. `Array`형식의 큐 구현시 시간 복잡도에 대한 고민

- `enqueue`작업을 하는 부분은 배열의 끝에 요소를 추가하는 `append`메서드로 시간복잡도 O(1)로 문제가 없지만,
- `dequeue`작업을 하는 부분은 `removeFirst`메서드를 사용하여 배열의 맨 앞의 요소를 추출해 배열의 전체요소의 index가 -1되다보니, 시간복잡도가 O(n)으로 `dequeue`작업은 오버헤드를 발생합니다.
- 이러한 단점을  Int형 변수인 `head`를 추가함으로써 `removeFirst`메서드를 사용하지 않고, `head`의 위치를 1씩 증가시키며 nil 값을 할당해주는 방식으로 구현하여 O(1)의 시간복잡도를 갖는 메서드로 구현해보았습니다.
    - `nil` 값으로 할당된 배열은 `head`의 값이 `queue`크기의 25% 를 차지하게되면 nil 값을 remove하도록 구현하였습니다!
### 2. `LinkedList`와 `Array` 선택에 대한 고민 
- 계산기 구현시 특정 값을 찾아 사용하는것이 아닌 값을 넣은 순서대로 사용한다고 판단되어 Array를 채택하였고 Array의 단점을 보완하는 방향으로 구현해보았습니다.

## 7. **🔗 참고 링크**

[[Swift]안전하게 배열 조회하기](http://minsone.github.io/programming/check-index-of-array-in-swift)
