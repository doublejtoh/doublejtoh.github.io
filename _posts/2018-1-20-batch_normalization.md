---
layout: post
title: Batch Normalization
---


### Deep Neural Network에서의 문제점

Layer가 많이 쌓이면 쌓일수록 학습이 잘 안될 수 있다. 많은 파라미터들이 존재하게 되어 특정 레이어에서의 W값의 작은 변화가 상위 Layer에 더 큰 W값의 차이로 
이어지게 될 수 있다.
이와 같이 hidden layer안의 노드 값의 변동이 심하게 되는 현상을 Internal Covariate Shift라고 한다.
즉, Internal Covariate Shift란 hidden layer에서의 노드 값이 기존의 값과 차이가 크게 되면 어떻게 학습해야 되는지 모르게 되는
현상이다.
예를 들어, Training and Testing data가 있을 때 Training data와 Test data의 distribution gap이 너무 커서 Training Data에 맞춰진 hidden layer의 W값들이 Test data에서 성능이 잘 안나오는 것과 비슷한 경우라고 볼 수 있겠다.

### 이러한 문제점들에 대한 임시방편 Solutions

1. Careful initialization
 RBM같은 initilaization기법을 사용할 수 있겠지만 어렵다.


2. Small Learning rate
 학습이 더디며, local minimum point에 빠질 가능성이 높아진다.

### Batch Normalization이 왜 일어나는가?




