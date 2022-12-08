# Emotion

A Flutter project uses CNN ML model to identify emotion of a human face.

## Technique Demonstration

Methodology:
We have chosen three optimizers and three learning rates for each of them. We have trained our model on each of their combinations and analysed the results obtained.
 
 
Data set:
The dataset we have chosen is called fer2013. It was obtained from Kaggle public dataset resource.


- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)

##Google Net
It is considered one of the latest CNN models that gives reduced error when trained on a huge image dataset like ImageNet. It is applicable to applications like Google Photos and Flickr . In our case study ,we have chosen different optimizers with different learning rates to measure the performance of GoogleNet with these choices.The reason for choosing GoogleNet is it has given excellent results in many ImageNet contests. In Fact it was the winning CNN model for the ImageNet contest 2014. GoogleNet had 12 fewer parameters as compared to winner architecture from two years and it had more accuracy as well.

The layers used in our model are: Conv2D, BatchNormalization, Input Layer(Activation Relu), Maxpool2D layer, AveragePooling2D, Flatten and Dense(Activation softmax) layer.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference
