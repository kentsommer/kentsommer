+++
date = "2016-09-20T12:00:00"
draft = false
tags = ["Technical", "Life Abroad"]
title = "Tensors, Baseball, and a whole lot of fun"
math = true
+++

It has taken a while for me to really feel settled in here, but I think I've finally crossed that line and I'm starting to feel really blessed to be here. 

The last couple weeks have been an absolute blast and given the fact that I basically get to build cool things every day, so should the rest of my time here. As far as classes go... I can't really pick out many differences so far compared to the structure of similar graduate level courses in the US. Perhaps in some classes, there is a bit more emphasis on fact memorization, but even that seems to be within the bounds of normal. I've mentioned this to a few people now whenever they ask what the big differences between the US and Korea are, but it is actually really hard to say. Once you step off the plane, everything is so radically different and yet so easy to become accustomed to that you hardly realize the changes in lifestyle or cultural behavior. In that sense, I think Korea is a great tourist destination not because it is easy to get around without knowing the language (it isn't... it is actually pretty hard), but simply because you get used to the radical differences extremely quickly.

Now, you probably read the title of this post and by this point, you are thinking what in the world does any of this have to do with tensors, to which the obvious answer is... absolutely nothing. But, let's change that. Not too terribly long ago, Google released its machine learning library "TensorFlow"

> TensorFlow™ is an open source software library for numerical computation using data flow graphs. Nodes in the graph represent mathematical operations, while the graph edges represent the multidimensional data arrays (tensors) communicated between them. 

This library is not dissimilar to other machine learning libraries such as Caffe, Theano, etc., however, since it is new and probably most importantly required for use in a homework assignment, it is the library I am using at the moment. Machine learning has recently gotten a lot of attention in the area of Computer Vision for achieving really awesome results for tasks such as object/place recognition, and image captioning. My foray into TensorFlow (due to the homework assignment) has been focused on image retrieval using CNN (Convolutional Neural Network) features. Given a pre-trained VGG16 network as shown here:

![alternative text for search engines](/img/posts/vgg16.png)

If you use the second 1x1x4096 fully connected layer (fc2) as a feature vector on a given query image, and then again pull out the fc2 feature vector on each image in some set that is known to contain similar or identical images (even those taken at different angles or scales), it becomes possible to match the feature vectors (using some similarity measurement) and retrieve pictures of the same image or similar ones. While this approach is naive, and if running solely on a CPU it is also stupidly slow (for 250 query images and a test set of 1000 it takes 29.86 hours to run), it still manages to achieve very acceptable results. Do note, this would be orders of magnitude faster given a GPU with enough vRAM, however, my measly 2GB card runs out of memory on this task. All of that being said, the precision achieved is actually impressive. It is able to achieve 92% accuracy when trying to match the closest 4 images in the test dataset to some image category in the query dataset. 

While this work is barely scratching the surface of what is currently possible using machine learning, it is still extremely impressive compared with the past work in image matching using hand crafted features (SIFT, SURF, ORB, etc). 

Source code for the above: https://github.com/kentsommer/VGG16-Image-Retrieval

Now... baseball. Anyone who knows me is aware of the fact that I've never particularly liked watching baseball mainly due to the fact that there just simply isn't a heck of a lot happening most of the time. I'm sure it is fun to play, just not the quickest paced spectator sport. Well, let me tell you, watching baseball in Korea flips that idea on its head. While the game itself is still slow, you can't focus on that most of the time because the bits where nothing is happening are all filled with syncronized cheering, chanting, and dancing. Every time "your team" is up to bat, the cheering man (for lack of a better description) gets up on a stage and starts directing. These chants/cheers are also distinctly different from the US style of cheerleading songs mainly because they are very specific to whoever is batting. Each player has their own "theme-song" if not multiple songs. Everyone, and I mean EVERYONE sings along and waves their hands about. It is a blast and the energy is greater than that of almost any professional sports game I've been to in the US (granted its a pretty small sample size...). If you ever come to Korea make sure to try to catch a baseball game (and bring a Korean friend with who can help guide you with what you are supposed to be chanting) even if you aren't a huge fan of the game normally. Here is a short clip of the crowd after the team we were cheering for hit a homerun to finish off the game and win (and yes I know it is stupid that I recorded it vertically but hey it is in 4K!):

{{< youtube -3izxpVzTZM >}}