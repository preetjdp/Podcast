# Quirks

Below are the quirks and discoveries made during the development of the application.

## The API

The API being used is by [Listen Notes](https://www.listennotes.com/api/docs/).

The API is super powerful, the only quirk I found was the API did not have a consistent schema.
Meaning the result type for the search query and fetch episodes query is entirely different, fulfilling those would require a more complex and elaborate Model with factory methods for each type of result.

## The Plugin

The Plugin which does most of the heavy lifting is [Assets Audio Player](https://github.com/florent37/Flutter-AssetsAudioPlayer) (Mad props to [Florent Champigny](https://twitter.com/florent_champ))

Faced Two Hiccups while using the plugin, namely

- Check Buffering State

  Although a ValueNotifer for Buffering was available, it was not a part of the RealTimePlayerInfo stream.

  Added the functionality with this [PR.](https://github.com/florent37/Flutter-AssetsAudioPlayer/pull/184)

- Get CrossProtocol Redirects working

  Given Listen Notes acts as a proxy for the audio files that It serves, some of the audio files might be `HTTP`, and the protocol switch (HTTPS ==> HTTP) is something exoplayer does not like.

  Fortunately Fixed it, by forking the plugin and plan to submit a PR.

  [Discussion here.](https://github.com/florent37/Flutter-AssetsAudioPlayer/issues/188)

## Search

Implementing search was fairly simple. What was not simple was using the `showSearch` function.

The thing is the `showSearch` function is not very extensible, meaning it does not expose the valueNotifier for the textController.

To Mitigate this created a complex abstraction that does most of the heavy lifting, allows me to have streams, and debounce them.

https://github.com/preetjdp/Podcast/blob/c08be93025fb5ac1696033ea926eef982ce94faa/lib/ui/components/podSearchDelegate.dart#L17-L47
