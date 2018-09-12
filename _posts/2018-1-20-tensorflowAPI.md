---
layout: post
title: 나만의 tensorflow의 API 사전
---



**tf.matmul과 multiply의 차이

```python

matrix1 = tf.constant([[3., 3.]]) # 1 x 2 shape
matrix2 = tf.constant([[2. ], [2. ]]) # 2 X 1 shape

tf.matmul(matrix1, matrix2).eval()
# output: array([[ 12. ]], dtype=float32)

(matrix1 * matrix2).eval()
# output: array([[6., 6.], [6., 6.]], dtype=float32)
```

**BroadCasting

```python
matrix1 = tf.constant([[3., 3.]])
matrix2 = tf.constant([[2.], [2.]])
(matrix1+matrix2).eval()
# output: array([[ 5., 5.],
                  [5., 5.]],dtype=float32)
```

