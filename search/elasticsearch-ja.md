## wiki
https://qiita.com/shin_hayata/items/41c07923dbf58f13eec4

## install plugins
elasticsearch-plugin install analysis-icu
elasticsearch-plugin install analysis-kuromoji
elasticsearch-plugin install org.codelibs:elasticsearch-analysis-kuromoji-ipadic-neologd:7.2.0

## drop index
DELETE ja_test

## create index
PUT ja_test
{
  "settings": {
    "analysis": {
      "analyzer": {
        "kuromoji_base": {
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
        },
        "kuromoji_read": {
          "type":      "custom",
          "tokenizer": "kuromoji_tokenizer",
          "char_filter": [
            "icu_normalizer",
            "kuromoji_iteration_mark"
          ],
          "filter": [
            "kuromoji_readingform",
            "kuromoji_part_of_speech",
            "ja_stop",
            "kuromoji_number",
            "kuromoji_stemmer"
          ]
        },
        "kuromoji_ipad_base": {
          "type":      "custom",
          "tokenizer": "kuromoji_ipadic_neologd_tokenizer",
          "char_filter": [
            "icu_normalizer",
            "kuromoji_ipadic_neologd_iteration_mark"
          ],
          "filter": [
            "kuromoji_ipadic_neologd_baseform",
            "kuromoji_ipadic_neologd_part_of_speech",
            "ja_stop",
            "kuromoji_number",
            "kuromoji_ipadic_neologd_stemmer"
          ]
        },
        "kuromoji_ipad_read": {
          "type":      "custom",
          "tokenizer": "kuromoji_ipadic_neologd_tokenizer",
          "char_filter": [
            "icu_normalizer",
            "kuromoji_ipadic_neologd_iteration_mark"
          ],
          "filter": [
            "kuromoji_ipadic_neologd_readingform",
            "kuromoji_ipadic_neologd_part_of_speech",
            "ja_stop",
            "kuromoji_number",
            "kuromoji_ipadic_neologd_stemmer"
          ]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "text": {
        "type": "text",
        "analyzer": "kuromoji_base",
        "search_analyzer": "kuromoji"
      }
    }
  }
}

## search all
GET ja_test/_search
{
	"query": {
		"match_all": {}
	}
}

## kuromoji_stemmer token filter
POST ja_test/_analyze/
{
  "analyzer": "kuromoji_base",
  "text": "単にコンピュータと言った場合、一般的には、プログラム内蔵方式のデジタルコンピュータの中でも、特にパーソナルコンピュータや、メインフレーム、スーパーコンピュータ、マイクロコンピュータなどを含めた汎用的なシステムを指す。"
}

## kuromoji_iteration_mark character filter
POST ja_test/_analyze/
{
  "analyzer": "kuromoji_base",
  "text": "ところゞゝゝ、ジヾが、時々、馬鹿々々しい。"
}

## kuromoji_baseform token filter
POST ja_test/_analyze/
{
  "analyzer": "kuromoji_base",
  "text": "お寿司が食べたいです。"
}

POST ja_test/_analyze/
{
  "analyzer": "kuromoji_read",
  "text": "お寿司が食べたいです。"
}

POST ja_test/_analyze/
{
  "analyzer": "kuromoji_base",
  "text": "食べる"
}

POST ja_test/_analyze/
{
  "analyzer": "kuromoji_read",
  "text": "食べる"
}

## 送り仮名 名詞
POST ja_test/_analyze/
{
  "analyzer": "kuromoji_base",
  "text": "お見積りをいただけないでしょうか？"
}

POST ja_test/_analyze/
{
  "analyzer": "kuromoji_base",
  "text": "お見積をいただけないでしょうか？"
}

## 送り仮名 動詞
POST ja_test/_analyze/
{
  "analyzer": "kuromoji_read",
  "text": "彼女は研究に心身を打ち込んだ。"
}

POST ja_test/_analyze/
{
  "analyzer": "kuromoji_read",
  "text": "彼女は研究に心身を打込みました。"
}

POST ja_test/_analyze/
{
  "analyzer": "kuromoji_base",
  "text": "打込"
}

POST ja_test/_analyze/
{
  "analyzer": "kuromoji_read",
  "text": "打込"
}

## 送り仮名 動詞 打ち合わせ=打合わせ=打合せ
POST ja_test/_analyze/
{
  "analyzer": "kuromoji_read",
  "text": "打ち合わせはいつですか？"
}

POST ja_test/_analyze/
{
  "analyzer": "kuromoji_read",
  "text": "打合わせの日時を相談したいです。"
}

## 送り仮名 動詞 引越=引越し=引っ越し
POST ja_test/_analyze/
{
  "analyzer": "kuromoji_read",
  "text": "引っ越し会社を選んでください。"
}

POST ja_test/_analyze/
{
  "analyzer": "kuromoji_read",
  "text": "引越し会社を選んでください。"
}

POST ja_test/_analyze/
{
  "analyzer": "kuromoji_read",
  "text": "引越会社を選んでください。"
}
