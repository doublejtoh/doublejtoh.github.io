---
layout: post
title: Batch Normalization
---
 

# Image inpainting을 이용한 건축물 이미지 복원

This project is based on Jiahui Yu, et al. “Generative Image Inpainting with Contextual Attention”. Mar 2018. arXiv.<br><br>

### Test 환경
1. Nvidia Titan V (12GB memory) 사용. 40시간 학습 (1100 image data, 80000번 학습)
2. **전처리**:
트레이닝 데이터들을 256x256으로 resize 하고 이미지 파일들의 이름을 image1, image2, … 와 같이 넘버링 한다.
테스트 데이터들은 테스트 데이터와 같은 size의 마스크 이미지를 만든다.
3. **트레이닝 데이터 셋 구성**: 
사용한 데이터는 겹치지 않는 정면 위주의 중세시대 건축물 이미지 약 1100장이다. 트레이닝 데이터는 전처리를 거쳐 256x256 크기의 온전한 중세 건축물 이미지로 맞춰진다. Runtime에 각 트레이닝 데이터 이미지에 마스크가 랜덤하게 생성되어 input으로 들어가게 된다.
4. **테스트 데이터 셋 구셍**:
트레이닝 데이터와 겹치지 않는 정면 위주의 중세시대 건축물 이미지 중 손상된 건축물 이미지와 임의로 마스크 씌운 이미지 모두를 테스트 한다. 테스트 데이터는 이미지 사이즈에 상관없이 다양한 이미지를 사용하되, 2000x2000이상의 이미지는 memory usage issue때문에 사용하지 않는다. 그리하여 테스트할 때, 테스트 이미지의 훼손된 부분을 마스킹 한 이미지와 테스트 이미지를 사용한다.<br><br><br>

### 20000번 학습된 모델로 임의의 트레이닝 데이터에 대해서 inpainting한 결과
왼쪽부터 ground truth(온전한 건축물 이미지), Input(모델에 들어갈 임의로 마스크 처리된 인풋), Output, contextual attention map.
![20000step ](/images/20000step.png)

20000번 학습된 결과가 너무 흐릿하고 blur한 경향이 있어서 hyper parameter 조정을 하였다. 구체적으로 coarse L1 loss와 auto encoder L1 loss, reconstruction L1 loss 값을 각각 1.2에서 2.0으로 높여서 80000번 까지 학습을 진행하였다.<br><br><br>

### 80000번 학습된 모델로 임의의 트레이닝 데이터에 대해서 inpainting한 결과
왼쪽부터 ground truth(온전한 건축물 이미지), Input(모델에 들어갈 임의로 마스크 처리된 인풋), Output, contextual attention map.
![80000step 1](/images/80000step.png)
![80000step 2](/images/80000step_2.png)
![80000step_3](/images/80000step_3.png)
80000번 학습된 결과에서는 blur하지는 않지만 inpainting한 결과가 조금 부자연스러운 경향이 있다. 이는 학습된 데이터 개수가 적어서 generator가 global consistency를 충분히 고려하지 못한 채 image inpainting 한 것으로 보여진다.<br><br><br>

### 80000번 학습된 모델로 임의의 테스트 데이터에 대해서 inpainting한 결과
왼쪽부터 Raw input(마스크 처리되지 않은 pure한 손상된 건축물 이미지), 손상된 부분 마스킹 이미지, Output(모델이 생성해낸 이미지).
![results 1](/images/result1.png)
![results 2](/images/result2.png)
![results 3](/images/result3.png)
단순한 형태의 테스트 데이터에 대해서는 어색하지 않은 결과물을 만들어내는 반면 복잡한 양식에 대해서는 다소 어색한 결과물이 생성된다. 이는 트레이닝 데이터 중 해당 양식과 관련된 데이터가 부족하여 발생한 문제이다.<br><br><br>

### 추후 연구 방향 
본 논문에서는 generative image inpainting의 방법을 활용하여 건축물에서 손실 영역을 복원하는 모델을 고안해보았다. 현재 training data에 대해서나 test data에 대해서 inpainting 결과가 뛰어나지는 않다. 단순한 패턴의 건축물은 매우 적합하게 복원되는 반면 창문이나 복잡한 구조들은 복원이 어색하다. 이는 학습한 데이터의 자료가 부족해서인데 training data를 더 모아서 학습을 진행시켜 성능을 더 좋게 할 것이고, 나아가 다른 건축물 양식 training data도 모아서 추가적으로 fine tunning하여 추가적으로 학습시킬 것이다.<br><br><br>



