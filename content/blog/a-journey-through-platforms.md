---
author: "Kent Sommer"
date: 2017-02-03
linktitle: A Journey Through Platforms
title: A Journey Through Platforms
highlight: true
---

So, it has been some time since my last post... Before I get into the fun stuff (well... fun for me anyways), let me give you a bit of a life update! Having already finished 1/4th of my masters, I can say with confidence that I am really happy that I decided to continue on and get an advanced degree. I'm able to work with world-class researchers on amazing topics doing work that has the potential to drastically improve people's lives. If someone would have told me when I was in high school that this is the type of work I would be doing, I probably would have laughed at them. Not because I wouldn't want to be doing it, but simply because at that time I thought there was no way I possibly could. It has taken until probably just a month or two ago for me to finally realize I'm actually capable of contributing meaningfully to research. Why it took so long to shake the constant feeling of imposters syndrome is something I probably will never know. I've struggled a lot with self-confidence in the past but just being in Korea and constantly overcoming challenges both academic and otherwise has really helped to put things into perspective and pushed me to grow a lot as a person. 

Since finals have finished I've been working in the lab on a few projects, giving seminars on deep learning, and contributing back a bit to the open source community. I'm not actually sure what I am allowed to say publicly about the projects so I won't go into much detail on those, however, I get to work with the Hubo lab ([the lab that won the DARPA 2015 Robotics Challenge](https://www.google.co.kr/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwiX-8_75_zRAhUIGJQKHU7rB8oQtwIIGDAA&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DBGOUSvaQcBs&usg=AFQjCNGsgOcG0NXTfl1TzgClCFSjn01elw&sig2=285L1YiiOgTdxRy52SL1ZQ&bvm=bv.146094739,d.dGc)) as well as a group from Seoul National University. The seminars have actually been a blast so far, and of course teaching always (most of the time) forces you to better understand the material yourself which is obviously beneficial to me. My professor suggested that three of us in the lab go through a deep learning textbook in detail and present on all of the chapters. Partially to help bring anyone in the lab who maybe wasn't very familiar up to speed a bit, but also to just really solidify all the concepts for those of us giving the seminars. As for the open source work I've been doing, none of the code is novel, but rather helps to improve access to deep learning models by implementing them in more accessible frameworks (Keras for example). 

The first two open source releases I made were implementations of a model called PoseNet. PoseNet was based on GoogLeNet and works by replacing the final and auxiliary fully connected layers (used for image classification) with regression outputs. When I say regression I mean that it outputs continuous values instead of a number within some set range (say 0 to 1000 where each number represents a class as in imagenet). As I said before I have two implementations available for PoseNet (the original author also has a Caffe implementation): 

1. [Keras based implementation](https://github.com/kentsommer/keras-posenet)
2. [Tensorflow based implementation](https://github.com/kentsommer/tensorflow-posenet). 

More recently, after reading through Google's paper on their latest version of the Inception architecture (Inception-V4), I decided it would be a good exercise to try and implement the model in Keras and port the weights that they released for TFslim (Tensorflow slim). This ended up taking up more of my time than I had originally intended, however, I learned a ton on the journey. 

(Just a quick warning, the rest of this post will likely be rather technical although I will do my best to make it easy to understand) 

The first large hurdle was that the pre-trained weights that Google released were in a ckpt (checkpoint) file which is the standard for Tensorflow but is also kind of a pain to use if you want to just get at the data (after all, we really just need the weights as arrays). After hacking together a really ugly solution to read the weights from the ckpt file and set them layer by layer into the Keras implementation of the model, I ran into my first bug (one that would drive me nuts for the better part of a day). No matter what I tried, the model always predicted the class of my test image horribly wrong (would classify an elephant as a toilet, etc...). As I become more frustrated I finally started to hack up my model implementation to try and fix the issue. There ended up actually being three weird bugs: 

1. The first was that I had somehow missed that Batch Normalization was supposed to be applied after EVERY convolution layer. 
2. The second was that for whatever reason, applying rectified linear unit activation before Batch Normalization drastically hurt performance. While the original papers that used Batch Normalization apply the layer activations after it, recent trends have been to apply activations first and the results "should" be really similar no matter what the order is. My guess is that I'm missing some information on why this caused such a large performance hit, so now that I've got everything working I'll do some research on that topic. 
3. The third and possibly most perplexing is that when using Batch Normalization, the biases in convolutional layers technically become "useless in the calculation." So, I expected that allowing the biases in the convolutional layers to be initialized would not throw off the predictions by much (if at all). It turns out... it does. Keras makes it easy luckily to simply remove the biases from convolutional layers, so after setting the ```bias=False``` flag, everything finally worked. 

After hacking together some performance testing scripts to validate the accuracy of the model against the imagenet validation dataset, I was finally able to show equal quality results to that of the original model. And while I would like to say that was the end of it... it wasn't. Because Keras supports two backends (Theano and Tensorflow), and Theano implements the convolution operation differently than Tensorflow, the weights needed to be ported from the Tensorflow backend to the Theano backend. Converting the convolution kernels ends up being really easy though:

```
from keras import backend as K
from keras.utils.np_utils import convert_kernel

for layer in model.layers:
   if layer.__class__.__name__ in ['Convolution1D', 'Convolution2D']:
      original_w = K.get_value(layer.W)
      converted_w = convert_kernel(original_w)
      K.set_value(layer.W, converted_w)
```

This change allows you to switch the backends and use Theano! However, since Theano typically takes in images with the dimension ordering (channels, width, height), and Tensorflow takes in images with dimension ordering (width, height, channels) it is also necessary to do some weight matrix transposing magic to make everything work. This process is also pretty simple though:

```
for index, layer in enumerate(layers):
    if th_layer.__class__.__name__ in conv_classes:
        weights = weights_list[index]
        weights[0] = weights[0].transpose((3,2,0,1))
        layer.set_weights(weights)
        print('converted ', layer.name)
    else:
        layer.set_weights(weights_list[index])
        print('set: ', layer.name)
``` 

The only bit that tripped me up initially is that the author or Keras had mentioned in a [google forums post](https://groups.google.com/forum/#!searchin/keras-users/convert$20weights$20tensorflow%7Csort:relevance/keras-users/E1W4HpuxxFw/B2DCDluTCwAJ) that it is also necessary to row shuffle the weights of the first fully connected layer. I ended up not needing to do this, and I'm not exactly sure why it was mentioned as necessary originally. However, it did cause me to go on a wild goose chase looking for a solution to a problem I didn't have. Finally, I deduced the row shuffling was unnecessary, fixed the last (stupidly simple) remaining bug and everything "just worked." Given a picture of an elephant as input, for instance, you would get the following (assuming you use the same image of an elephant I did):

```
Loaded Model Weights!
Class is: African elephant, Loxodonta africana
Certainty is: 0.868498
```

If you are interested in playing around with the model (I promise it doesn't bite!), feel free to get it [from here](https://github.com/kentsommer/keras-inceptionV4)! The takeaway from this whole adventure for me has been a much better understanding of the implementation differences between Theano and Tensorflow. Although frustrating at times, it was a really fun experience and if I have some more free time I wouldn't mind porting some other popular models to Keras or any other framework. So... if you have any ideas, leave a comment or shoot me an email and I'd be happy to look into porting it! 

That's all, for now, folks!

