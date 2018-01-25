---
layout: post
title: Batch Normalization
---


### Deep Neural Network에서의 문제점

Layer가 많이 쌓이면 쌓일수록 학습이 잘 안될 수 있다. 많은 파라미터들이 존재하게 되어 특정 레이어에서의 W값의 작은 변화가 상위 Layer에 더 큰 W값의 차이로 
이어지게 될 수 있다.
이와 같이 hidden layer안의 노드 값이 **가중되어** 변동이 심하게 되는 현상을 Internal Covariate Shift라고 한다.
즉, Internal Covariate Shift란 hidden layer에서의 노드 값이 기존의 값과 차이가 크게 되면 어떻게 학습해야 되는지 모르게 되는
현상이다.
예를 들어, Training and Testing data가 있을 때 Training data와 Test data의 distribution gap이 너무 커서 Training Data에 맞춰진 hidden layer의 W값들이 Test data에서 성능이 잘 안나오는 것과 비슷한 경우라고 볼 수 있겠다.

### 이러한 문제점들에 대한 임시방편 Solutions

1. Careful initialization<br>
 RBM같은 initilaization기법을 사용할 수 있겠지만 어렵다.


2. Small Learning rate<br>
 학습이 더디며, local minimum point에 빠질 가능성이 높아진다.
 
 ### Internal Covariate Shift를 제대로 해결하기 위한 Batch Normalization!
 
 Batch normalization은 다음과 같은 사실을 가정한다.<br>
 
 ** Hidden Layer에서의 W값이 변하는 범위가 작게되면 학습이 잘 일어날 것이다! **
 
 

![batch norm pic 1 ](/images/batch_norm_pic1.png)
왼쪽의 경우 batch norm을 적용한 경우의 distribution과 기존의 distribution을 나타낸 것이고, <br>
오른쪽의 경우 batch norm을 적용하지 않은 경우의 distribution과 기존의 distribution을 나타낸 것이다.<br>
왼쪽의 경우 BN이 적용되기 때문에 분산과 평균이 기존의 distribution과 크게 다르지 않아져서 layer가 계속 중첩되도 학습이 잘 되는 반면,<br>
오른쪽의 경우 BN을 적용하지 않았기 때문에 분산과 평균이 기존의 distribution보다 크게 달라져서 오른쪽 위의 그림과 같이 layer가 많이 중첩되면
학습이 잘 되지 않는 것을 볼 수 있다.


### Batch Normalization하는 방법 ###

생각보다 간단하다. mini batch에 대해서 평균과 분산을 구한 후, 표준 정규화를 통해 normalize해준다.<br>
이 때 정규화 한 distribution에 대해서 감마를 곱해주고, Biased B 를 더해주어서 normalize되는 scale을 shift해준다.<br>
scale shift를 위한 변수(r(감마),B)는 backpropagation을 통해 learning 될 수 있다.<br>
그 이유는 batch normalization한 결과로 sigmoid와 같은 activation에 들어가게 될 때 그래프에서 보면 값이 -1~1 사이에 분포하게 되면 nonlinearity를 보장하지 못할 수 있기 때문에, 값의 범위를 좀 더 넓혀주어서 nonlinearlity를 조금 더 확보해줄 수 있도록 한다.<br>


### Batch Normalization을 쓰면 좋은 점 ###

<li> covariate internal shift 문제를 해결해준다. </li>
<li> 더 큰 learning rate를 줄 수 있다. </li>
<li> initialization을 크게 신경쓰지 않아도 학습이 잘 된다. </li>
<li> dropout이 크게 필요하지 않는다. </li>
<li> ## 성능이 대체로 좋아진다. ## </li>






