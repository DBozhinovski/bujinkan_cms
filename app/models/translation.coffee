translation_data =
  "news": "Новости"
  "about": "За нас"
  "ninjutsu": "Нинџутсу"
  "bujinkan": "Буџинкан"
  "seminars": "Семинари"
  "contact": "Контакт"
  "magazine": "Списание"
  "training center": "Тренинг центар"


class Translation
    @get: (key) ->
        translation_data[key]

module.exports = Translation




