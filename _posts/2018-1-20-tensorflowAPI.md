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

tensor의 shape으로부터 dimension size가 1인 것들을 제거한다.

```python
# t는 [1, 2, 1, 3, 1, 1] 의 shape을 가지고 있는 tensor라고 가정하자.
tf.shape(tf.squeeze(t)) # output : 2 X 3 tensor

```

## tf.expand_dims

tensor의 shape에 dimension을 1 추가 한다.

```python
# t는 [2]의 shape를 갖는 tensor라고 가정하자.
tf.shape(tf.expand_dims(t, 0)) # output shape: [1, 2]
tf.shape(tf.expand_dims(t, 1)) # output shape: [2, 1]
tf.shape(tf.expand_dims(t, -1)) # output shape: [2, 1]

# t2는 [2, 3, 5]의 shape를 갖는 tensor라고 하자.
tf.shape(tf.expand_dims(t2, 0)) # output shape: [1, 2, 3, 5]
tf.shape(tf.expand_dims(t2, 2)) # output shape: [2, 3, 1, 5]
tf.shape(tf.expand_dims(t2, 3)) # output shape: [2, 3, 5, 1]
```

## tf.one_hot

```python

indices = [0, 1, 2]
depth = 3
tf.one_hot(indices, depth) # output shape: [3, 3]
# [[1., 0., 0.],
  [0., 1., 0.],
  [0., 0., 1.]]
```
원래 shape 가 [ A, B ] 였다면, one_hot을 거치면 shape이 [ A, B , Depth]가 된다.

## tf.cast

```python
tf.cast([1.8, 2.2, 3.3, 4.9], tf.int32).eval() # output: [1, 2, 3, 4]. int32 tensor로 캐스팅된다.
tf.cast([True, False, 1 == 1, 0 == 1], tf.int32).eval() # output: [1, 0, 1, 0]
```


## tf.transpose

좋은 예제가 있어 공유한다. <br>
http://superelement.tistory.com/18


## tf.contrib.layers.flatten

batch_size는 유지하고, 그에 따른 나머지를 알맞게 reshape해준다. 

```python
x = np.arange(40).reshape(4, 2, 5)
flattened_x = tf.contrib.layers.flatten(x)
print(flattened_x.eval())  # output shape : (4 X 10)

```

<li> Q: 왜 flatten을 사용할 까? </li>
A: <a href="https://stackoverflow.com/questions/44572141/why-do-we-flatten-the-data-before-we-feed-it-into-tensorflow">Because when you're adding a fully connected layer, you always want your data to be a (1 or) 2 dimensional matrix, where each row is the vector representing your data.</a>

## tf.contrib.frameworks.arg_scope
When defining convolution layers, you may always use the same padding type and the same initializer, and maybe even the same convolution size. For you pooling, maybe you are also always using the same 2x2 pooling size. And so on.

arg_scope is a way to avoid repeating providing the same arguments over and over again to the same layer types.
CNN Layer들을 tf로 구현할 때, 같은 padding type, 같은 initializer, convolution size, pooling size들이 같은 layer들을 중첩적으로 사용하는 경우가 있다. 그럴 때, 필요한 것이 arg_scope이다.


```python
from third_party.tensorflow.contrib.layers.python import layers
  arg_scope = tf.contrib.framework.arg_scope
  with arg_scope([layers.conv2d], padding='SAME',
                 initializer=layers.variance_scaling_initializer(),
                 regularizer=layers.l2_regularizer(0.05)):
    net = layers.conv2d(inputs, 64, [11, 11], 4, padding='VALID', scope='conv1') # (1)
    net = layers.conv2d(net, 256, [5, 5], scope='conv2' # (2)
```

(1) 라인은 다음과 동일하다.

```python

   layers.conv2d(inputs, 64, [11, 11], 4, padding='VALID',
                  initializer=layers.variance_scaling_initializer(),
                  regularizer=layers.l2_regularizer(0.05), scope='conv1')
```

(2) 라인은 다음과 동일하다.

```python
  layers.conv2d(inputs, 256, [5, 5], padding='SAME',
                  initializer=layers.variance_scaling_initializer(),
                  regularizer=layers.l2_regularizer(0.05), scope='conv2')
```
  


