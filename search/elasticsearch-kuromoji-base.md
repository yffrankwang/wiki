## install plugins
elasticsearch-plugin install analysis-icu
elasticsearch-plugin install analysis-kuromoji

## drop index
DELETE ja_base

## create index
PUT ja_base
{
  "settings": {
    "analysis": {
      "analyzer": {
        "default": {
          "type":      "custom",
          "tokenizer": "kuromoji_tokenizer",
          "char_filter": [
            "icu_normalizer",
            "kuromoji_iteration_mark"
          ],
          "filter": [
            "kuromoji_baseform",
            "kuromoji_part_of_speech",
            "ja_stop",
            "kuromoji_number",
            "kuromoji_stemmer"
          ]
        }
      }
    }
  }
}

## kuromoji_stemmer token filter
POST ja_base/_analyze/
{
  "text": "単にコンピュータと言った場合、一般的には、プログラム内蔵方式のデジタルコンピュータの中でも、特にパーソナルコンピュータや、メインフレーム、スーパーコンピュータ、マイクロコンピュータなどを含めた汎用的なシステムを指す。"
}

POST ja_base/_doc/
{
  "text": "単にコンピュータと言った場合、一般的には、プログラム内蔵方式のデジタルコンピュータの中でも、特にパーソナルコンピュータや、メインフレーム、スーパーコンピュータ、マイクロコンピュータなどを含めた汎用的なシステムを指す。"
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "コンピュータ"
    }
  }
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "コンピューター"
    }
  }
}

## kuromoji_iteration_mark character filter
POST ja_base/_analyze/
{
  "text": "ところゞゝゝ、ジヾが、時々、馬鹿々々しい。"
}

POST ja_base/_doc/
{
  "text": "ところゞゝゝ、ジヾが、時々、馬鹿々々しい。"
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "時々"
    }
  }
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "時時"
    }
  }
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "馬鹿"
    }
  }
}

## kuromoji_baseform token filter
POST ja_base/_analyze/
{
  "text": "お寿司が食べたいです。"
}

POST ja_base/_doc/
{
  "text": "お寿司が食べたいです。"
}

POST ja_base/_analyze/
{
  "text": "食べる"
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "食べる"
    }
  }
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "食べ"
    }
  }
}

## 送り仮名 名詞
POST ja_base/_analyze/
{
  "text": "お見積りをいただけないでしょうか？"
}

POST ja_base/_analyze/
{
  "text": "お見積をいただけないでしょうか？"
}

POST ja_base/_doc/
{
  "text": "お見積りをいただけないでしょうか？"
}

POST ja_base/_doc/
{
  "text": "お見積をいただけないでしょうか？"
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "見積り"
    }
  }
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "見積"
    }
  }
}

## 送り仮名 動詞
POST ja_base/_analyze/
{
  "text": "彼女は研究に心身を打ち込んだ。"
}

POST ja_base/_analyze/
{
  "text": "彼女は研究に心身を打込みました。"
}

POST ja_base/_doc/
{
  "text": "彼女は研究に心身を打ち込んだ。"
}

POST ja_base/_doc/
{
  "text": "彼女は研究に心身を打込みました。"
}

POST ja_base/_analyze/
{
  "text": "打込"
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "打込"
    }
  }
}

## 送り仮名 動詞 打ち合わせ=打合わせ=打合せ
POST ja_base/_analyze/
{
  "text": "打ち合わせはいつですか？"
}

POST ja_base/_analyze/
{
  "text": "打合わせの日時を相談したいです。"
}

POST ja_base/_doc/
{
  "text": "打ち合わせはいつですか？"
}

POST ja_base/_doc/
{
  "text": "打合わせの日時を相談したいです。"
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "打合せ"
    }
  }
}

## 送り仮名 動詞 引越=引越し=引っ越し
POST ja_base/_analyze/
{
  "text": "引っ越し会社を選んでください。"
}

POST ja_base/_analyze/
{
  "text": "引越し会社を選んでください。"
}

POST ja_base/_analyze/
{
  "text": "引越会社を選んでください。"
}

POST ja_base/_doc/
{
  "text": "引っ越し会社を選んでください。"
}

POST ja_base/_doc/
{
  "text": "引越し会社を選んでください。"
}

POST ja_base/_doc/
{
  "text": "引越会社を選んでください。"
}

GET ja_base/_search
{
  "query": {
    "match": {
      "text": "引越"
    }
  }
}
