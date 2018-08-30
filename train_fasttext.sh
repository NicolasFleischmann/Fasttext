#!/bin/bash

if [ "$DOWNLOAD_WIKI" == "true"  ]
then
    echo "Downloading Wikipedia dump: $WIKI_PREFIX$WIKI_DUMP"
    wget $WIKI_PREFIX$WIKI_DUMP
fi

if [ "$CORPUS_TYPE" == "wiki" ]
then
    echo "Preprocessing Wikipedia Dump"
    python3 process_wikipedia.py $WIKI_DUMP $CORPUS
fi

OUTPUTDIR="$OUTPUTDIR/model"
##### train fasttext
./fasttext skipgram \
  -input $CORPUS \
  -output $OUTPUTDIR \
  -dim $VECTOR_SIZE \
  -epoch $MAX_ITER \
  -lr $LEARNING_RATE \
  -ws $WINDOW_SIZE \
  -minCount $VOCAB_MIN_COUNT \
  -wordNgrams $MAX_NGRAM_WORD \
  -bucket $N_BUCKETS \
  -minn $MIN_NGRAM_CHAR \
  -maxn $MAX_NGRAM_CHAR \
  -t $SAMPLING_THRESH \
  -thread $THREADS \
  -verbose $VERBOSE
