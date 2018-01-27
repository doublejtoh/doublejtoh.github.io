# Nojida Session Overview #

1. Javascript

2. Azure & Git

3. Node.js

4. Express.js : Node.js를 더 쉽게 개발할 수 있게 하는 툴

5. Socket.io :실시가 채팅을 위함

--------------------------------


let 과 var의 차이

let은 제일 가까운 블록안에서만 유효하다.
var은 함수 내에서 유효하다.

예제 1.
```javascript
function order(x,y){

	var tmp1 = x;
	
	if(y> 0){
		let tmp2 = y;
	}
	console.log(tmp1);
	console.log(tmp2);


}

order(1,2);
```

예제 2.
```javascript
var scope = 10;
function scopeExam(){

	var scope = 20;
	console.log("scope= "+scope);

}

scopeExam();
```

# 화살표 함수 : 무명 함수를 생성하는 함수 표현방법 중 하나

(params...) => (함수 내용)

# 객체 생성과 생성자
```javascript
var my_grade = {
  'math' : 100
  
}
```



생성자: 객체를 만드는 역할을 하는 함수
-> 코드의 재활용성 올라간다.

javascript에서는 생성자 또한 함수로 구현하는것이 대부분. 


javascript에서의 모듈 로드
<script src="모듈 이름"></script>

Node.js에서의 모듈 로드
```javascript
var 객체 = require('모듈 이름'); //require은 모듈을 가져온 다음 , 모듈을 사용할 수 있는 객체를 리턴해준다.
```

* 콜백과 비동기 처리 


콜백: 어떤 함수의 매개변수가 함수인 경우..
비동기 처리: non preemptive!


* 상속!

```javascript

function Person(){}

Person.prototype.introduce = function(myname){
	console.log("my name is"+ myname);
}

function Programmer(){}

Programmer.prototype = new Person()

Programmer.prototype.coding = function(){
	for (var i=1; i<=10; i++){
		console.log(i);
	}
}

var o = new Programmer();
o.introduce("jeong");
o.coding();

```
prototype은 뭔가 코드 내부에서 attribute들을 추가하면 시간도 오래걸리니깐 function 외부에서 attribute를 추가할 수 있게된다.

하지만.. 이렇게 attribute를 추가해주게 되면 접근방식이 public으로 설정되어 보안적으로 봤을 때 좋지 않다. 따라서 최근에는
ECMA JS나 typescript와 같은 언어들은 접근 방식을 명시하는 방법을 취하고 있다고 알려져 있다.
