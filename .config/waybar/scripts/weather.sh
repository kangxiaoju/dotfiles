#!/usr/bin/env bash

#status=$(curl -s 'http://wttr.in/shanghai?format=%C+|+%t')
#API_KEY="" # insert api key here
CITY="shanghai" # insert city here
# first comment is description, second is icon number
weather_icons_day=(
    [113]=  # Sunny/113
    [116]=  # Partly cloudy/116
    [119]=  # Cloudy/119
    [122]=  # Overcast/122
    [143]=  # Mist/143
    [176]=  # Patchy rain possible/176
    [179]=  # Patchy snow possible/179
    [182]=  # Patchy sleet possible/182
    [185]=  # Patchy freezing drizzle possible/185
    [200]=  # Thundery outbreaks possible/200
    [227]=  # Blowing snow/227
    [230]=  # Blizzard/230
    [248]=  # Fog/248
    [260]=  # Freezing fog/260
    [263]=  # Patchy light drizzle/263
    [266]=  # Light drizzle/266
    [281]=  # Freezing drizzle/281
    [284]=  # Heavy freezing drizzle/284
    [293]=  # Patchy light rain/293
    [296]=  # Light rain/296
    [299]=  # Moderate rain at times/299
    [302]=  # Moderate rain/302
    [305]=  # Heavy rain at times/305
    [308]=  # Heavy rain/308
    [311]=  # Light freezing rain/311
    [314]=  # Moderate or heavy freezing rain/314
    [317]=  # Light sleet/317
    [320]=  # Moderate or heavy sleet/320
    [323]=  # Patchy light snow/323
    [326]=  # Light snow/326
    [329]=  # Patchy moderate snow/329
    [332]=  # Moderate snow/332
    [335]=  # Patchy heavy snow/335
    [338]=  # Heavy snow/338
    [350]=  # Ice pellets/350
    [353]=  # Light rain shower/353
    [356]=  # Moderate or heavy rain shower/356
    [359]=  # Torrential rain shower/359
    [362]=  # Light sleet showers/362
    [365]=  # Moderate or heavy sleet showers/365
    [368]=  # Light snow showers/368
    [371]=  # Moderate or heavy snow showers/371
    [374]=  # Light showers of ice pellets/374
    [377]=  # Moderate or heavy showers of ice pellets/377
    [386]=  # Patchy light rain with thunder/386
    [389]=  # Moderate or heavy rain with thunder/389
    [392]=  # Patchy light snow with thunder/392
    [395]=  # Moderate or heavy snow with thunder/395
)

weather_icons_night=(
    [113]=  # Clear/113
    [116]=  # Partly cloudy/116
    [119]=  # Cloudy/119
    [122]=  # Overcast/122
    [143]=  # Mist/143
    [176]=  # Patchy rain possible/176
    [179]=  # Patchy snow possible/179
    [182]=  # Patchy sleet possible/182
    [185]=  # Patchy freezing drizzle possible/185
    [200]=  # Thundery outbreaks possible/200
    [227]=  # Blowing snow/227
    [230]=  # Blizzard/230
    [248]=  # Fog/248
    [260]=  # Freezing fog/260
    [263]=  # Patchy light drizzle/263
    [266]=  # Light drizzle/266
    [281]=  # Freezing drizzle/281
    [284]=  # Heavy freezing drizzle/284
    [293]=  # Patchy light rain/293
    [296]=  # Light rain/296
    [299]=  # Moderate rain at times/299
    [302]=  # Moderate rain/302
    [305]=  # Heavy rain at times/305
    [308]=  # Heavy rain/308
    [311]=  # Light freezing rain/311
    [314]=  # Moderate or heavy freezing rain/314
    [317]=  # Light sleet/317
    [320]=  # Moderate or heavy sleet/320
    [323]=  # Patchy light snow/323
    [326]=  # Light snow/326
    [329]=  # Patchy moderate snow/329
    [332]=  # Moderate snow/332
    [335]=  # Patchy heavy snow/335
    [338]=  # Heavy snow/338
    [350]=  # Ice pellets/350
    [353]=  # Light rain shower/353
    [356]=  # Moderate or heavy rain shower/356
    [359]=  # Torrential rain shower/359
    [362]=  # Light sleet showers/362
    [365]=  # Moderate or heavy sleet showers/365
    [368]=  # Light snow showers/368
    [371]=  # Moderate or heavy snow showers/371
    [374]=  # Light showers of ice pellets/374
    [377]=  # Moderate or heavy showers of ice pellets/377
    [386]=  # Patchy light rain with thunder/386
    [389]=  # Moderate or heavy rain with thunder/389
    [392]=  # Patchy light snow with thunder/392
    [395]=  # Moderate or heavy snow with thunder/395
)

#CITY=$(echo "$CITY" | curl -Gso /dev/null -w %{url_effective} --data-urlencode @- "" | cut -c 3- || true)
data=$(curl -s "https://wttr.in/$CITY?format=j1")
condition=$(echo $data | jq -r '.current_condition[0].weatherCode')
temp=$(echo $data | jq -r '.current_condition[0].temp_C')
feelslike=$(echo $data | jq -r '.current_condition[0].FeelsLikeC')
humidity=$(echo $data | jq -r '.current_condition[0].humidity')
sunset=$(echo $data | jq -r '.weather[0].astronomy[0].sunset')
is_day="1" #$(date '+%l:%M %p')

[ "$is_day" = "1" ] && icon=${weather_icons_day[$condition]} || icon=${weather_icons_night[$condition]}

echo "$icon  ${temp}°C"
