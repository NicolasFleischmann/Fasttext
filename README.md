# Dockerized training of fasttext embeddings

Fasttext embeddings are especially useful since you can obtain vectors even for out-of-vocabulary words, 
meaning words not seen at training time. 

## usage with Wikipedia
1. change "volumes" in docker-compose-wiki.yml to an existing! folder on your system
2. run `docker-compose -f docker-compose-wiki.yml up`
3. trained model files are in folder "output"    
    `model.vec` is a word + embedding combination, in standard word2vec format.
    
    `model.bin` can be loaded as fastText model for *out-of-vocab* words. 
    Explanation for installing fastText python version: https://github.com/facebookresearch/fastText/tree/master/python
    
## usage on own dataset
1. create an input txt file that is composed of words seperated by space. Newline character signals a new document. It should be UTF-8 encodable!
Full documentation on preprocessing: https://github.com/facebookresearch/fastText/blob/master/python/README.md#important-preprocessing-data--enconding-conventions
2. adjust variable CORPUS in docker-compose.yml to the txt file from 1.
3. change "volumes" in docker-compose.yml to an existing! folder on your system
4. run `docker-compose up`
5. trained model files are in folder "output"    
    `model.vec` is a word + embedding combination, in standard word2vec format.
    
    `model.bin` can be loaded as fastText model for *out-of-vocab* words. 
    Explanation for installing fastText python version: https://github.com/facebookresearch/fastText/tree/master/python
    
**troubleshooting**: We have encounter training divergence ("runtime-error: encountered NaN") on some unusual datasets. Try lowering the learning rate or 
play with the number of epochs (shouldnt be too high) 
    


