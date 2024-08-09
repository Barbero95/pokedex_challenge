# Eliminate languages that are not used or add new ones in case you need

mkdir -p lib/core/commons/services/translation/l10n

touch lib/core/commons/services/translation/l10n/intl_es.arb
touch lib/core/commons/services/translation/l10n/intl_en.arb

curl -XGET 'https://localise.biz/api/export/locale/es.arb?key=9TP9-lTRbSK9TbqZgMn50A5csnFuet5Z' > lib/core/commons/services/translation/l10n/intl_es.arb
curl -XGET 'https://localise.biz/api/export/locale/en.arb?key=9TP9-lTRbSK9TbqZgMn50A5csnFuet5Z' > lib/core/commons/services/translation/l10n/intl_en.arb
dart run intl_utils:generate