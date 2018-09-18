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

##### train fasttext
./fasttext skipgram \
  -input $CORPUS \
  -output "$OUTPUTDIR/model" \
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

## write model meta file
VOCAB_SIZE=$(cat $OUTPUTDIR/model.vec | wc -l)
echo "{
  'alias': 'fasttext',
  'embeddings_filename': 'model.vec',
  'vocab_filename': 'None',
  'input_field': '$TEXT_TYPE',
  'token_spacer': '$TOKEN_SPACER',
  'vocab_size': $VOCAB_SIZE,
  'train_params': {
    'VOCAB_MIN_COUNT': $VOCAB_MIN_COUNT,
    'VECTOR_SIZE': $VECTOR_SIZE,
    'MAX_ITER': $MAX_ITER,
    'WINDOW_SIZE': $WINDOW_SIZE,
    'LEARNING_RATE': $LEARNING_RATE,
    'MAX_NGRAM_WORD': $MAX_NGRAM_WORD,
    'MIN_NGRAM_CHAR': $MIN_NGRAM_CHAR,
    'MAX_NGRAM_CHAR': $MAX_NGRAM_CHAR
  },
  'notes': '$META_NOTES'
}" > $OUTPUTDIR/word_emb.meta