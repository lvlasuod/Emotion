# Emotion

A Flutter project uses CNN ML model to identify emotion of a human face.

Neural Netwrok Model Training Repository
- [humanface_emotions_detection](https://github.com/umar51/humanface_emotions_detection)

## Technique Demonstration

Methodology:
We have chosen three optimizers and three learning rates for each of them. We have trained our model on each of their combinations and analysed the results obtained. Optimizers are ADAM, SGD and RMSProp while learning rates are 0.01, 0.03, and 0.1. 
 
 
Data set:
The dataset we have chosen is called fer2013. It was obtained from Kaggle public dataset resource.


- [Verma, R. (2018) FER2013, Kaggle]([https://docs.flutter.dev/get-started/codelab](https://www.kaggle.com/datasets/deadskull7/fer2013))

## Google Net
It is considered one of the latest CNN models that gives reduced error when trained on a huge image dataset like ImageNet. It is applicable to applications like Google Photos and Flickr . In our case study ,we have chosen different optimizers with different learning rates to measure the performance of GoogleNet with these choices.The reason for choosing GoogleNet is it has given excellent results in many ImageNet contests. In Fact it was the winning CNN model for the ImageNet contest 2014. GoogleNet had 12 fewer parameters as compared to winner architecture from two years and it had more accuracy as well.

The layers used in our model are: Conv2D, BatchNormalization, Input Layer(Activation Relu), Maxpool2D layer, AveragePooling2D, Flatten and Dense(Activation softmax) layer.

![home](https://github.com/lvlasuod/Emotion/blob/master/home.png)

![Predicted](https://github.com/lvlasuod/Emotion/blob/master/Predicted.jpeg)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference
