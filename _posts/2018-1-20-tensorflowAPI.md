---
layout: post
title: 나만의 tensorflow의 API 사전
---

## tf.matmul과 multiply의 차이

```python

matrix1 = tf.constant([[3., 3.]]) # 1 x 2 shape
matrix2 = tf.constant([[2. ], [2. ]]) # 2 X 1 shape

tf.matmul(matrix1, matrix2).eval()
# output: array([[ 12. ]], dtype=float32)

(matrix1 * matrix2).eval()
# output: array([[6., 6.], [6., 6.]], dtype=float32)
```

## BroadCasting

```python
matrix1 = tf.constant([[3., 3.]])
matrix2 = tf.constant([[2.], [2.]])
(matrix1+matrix2).eval()
# output: array([[ 5., 5.],
                  [5., 5.]],dtype=float32)
```

## tf.reduce_mean/sum

tf.reduce_mean/sum은 axis 옵션을 주지 않는 이상 scalar값을 내놓는다. <br>
axis 옵션을 준다면, 한 차원 축소된 행렬이 결과값으로 나온다.

```python
x = [[1., 2.],
    [3., 4.]]
    
tf.reduce_mean(x).eval() # output: 2.5 
tf.reduce_mean(x, axis=1).eval() # output: [1.5, 3.5]
tf.reduce_mean(x, axios=0).eval() # output: [2., 3.]
tf.reduce_mean(tf.reduce_sum(x, axis=-1)).eval() # output: 5.0

```

## tf.argmax
tensor의 axis에 따른 최대값의 index을 리턴해준다. 말로하니 역시 어렵다.

```python
x = [[0, 1, 2],
    [2, 1, 0]]
tf.argmax(x, axis=0).eval() # output: [1, 0 ,0]
tf.argmax(x, axis=1).eval() # output: [2, 0]

```

## tf.squeeze

