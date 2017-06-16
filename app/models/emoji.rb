class Emoji
  POSITIVE_EMOJI = %w(
    :sparkles:
    :star:
    :star2:
    :dizzy:
    :boom:
    :+1:
    :ok_hand:
    :pray:
    :raised_hands:
    :clap:
    :metal:
    :dancers:
    :ok_woman:
    :zap:
    :sun_with_face:
    :squirrel:
    :flags:
    :fireworks:
    :sparkler:
    :gift:
    :balloon:
    :moneybag:
    :nut_and_bolt:
    :golf:
    :guitar:
    :hamburger:
    :ghost:
    :dart:
    :heart_eyes_cat:
  ).freeze

  def random(count: 3)
    POSITIVE_EMOJI.sample(3).join(' ')
  end
end
