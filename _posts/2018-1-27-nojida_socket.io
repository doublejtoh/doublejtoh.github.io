---
title: nojida-socket.io의 개념
layout: post
---

socket.io는 push가 핵심적인 개념이다.
socket.io는 양방향 통신이다. 

### socket.io의 특징
<li> 광범위한 브라우저 지원 </li>
<li> 사용에서의 편의성 </li>

## Push란 무엇인가?

request와 response의 연속이 web이라고 했는데, 채팅의 경우 이런식으로 request를 갱신해서 response를 그떄마다 보내주는 것이 push이다.

## push의 방법중 하나, polling:

client는 server쪽으로 지속적으로 request를 보내고, 그 때 마다 server는 response를 보낸다. 
즉, client에게 온 메시지가 있으면 그 메시지를 response에 포함시켜서 보내준다.
<br>이 방법은 좋지 않다. 예를 들어 지속적으로 request를 보내는 주기가 굉장히 짧으면 server입장에서는 굉장히 부하가 올 수 밖에 없게 된다.
반대로, 주기가 굉장히 길면, server입장에서는 보낼 response는 굉장히 많은데 client가 request를 보내지 않으므로 좋지 않다.
또한, 실시간성을 보장할 수 없다. 즉, 즉각적인 양방향 통신이 불가능 하다.

## push의 두번쨰 방법, Long Polling



## push의 세번째 방법,streaming

서버와 client사이의 연결이 끊어지면 안되는 것이 핵심. 서버와 client사이의 연결이 끊어지지 않기 때문에 이벤트가 일어날 때 마다 response를 그냥 주기만 하면 되므로 실시간성이
보장 된다 

## polling + long Polling + Streaming 을 모아서 module화 한것이 socket.io 이다. 따라서 이 모듈을 불러와서 개발할 수 있는 것이다!

### socket.io가 뭔데?

client와 server는 서로 연결 되기 전, 각각 socket을 만들어서 output port, input port를 가지게 된다. server쪽에서는 client의 소켓을 인식하게 된다.
따라서 여러 client가 보낸 메시지들을 server가 broadcast해줄 수 있게 되는 것이다.

slither.io 의 동작 방식 : 어떤 지렁이(client)의 이동 방향 벡터와 같은 데이터들이 client socket의 output stream을 통해 server의 input stream으로 
들어가게 된다.

단계별로 socket.io의 동작방식을 정리하면 다음과 같다.<br>

<li> 1. server socket 생성 </li>
<li> 2. client가 접속하여 server socket을 발견</li>
<li> 3. server socket과  연결되는 client socket 생성</li>
<li> 4. server가 client에서 socket이 생성된 것을 확인 </li>
<li> 5. serever socket과 client 사이 통신 준비 완료 </li>
 

```javascript
var io = require('socket.io').listen(httpServer); // server 에 socket 하나를 장착시키겠따!
var socket = io.connect(); // client가 소켓을 하나 생성.
io.sockets.on('connection',function(socket){}); // 'connection'은 이벤트임. client와 server가 소켓이 서로 연결되었다. connection이라는 이벤트가 일어나면 콜백으로 처리하겠다.


```

### Event Handling
```javascript

Emit('evtName',data); // 이러한 이벤트가 일어나면, 이벤트와 함께 이러한 data를 보내겠다.
on('evtName',Action callBack); 'evtname'이 발생하면 action callback을 실행하겠다.
```




