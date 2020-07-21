import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retro_music_player/models/Artists.dart';
import 'package:retro_music_player/responsive/responsive_layout.dart';
import 'package:retro_music_player/utils/constants.dart';
import 'package:retro_music_player/utils/utils.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';

/// To open a new screen use:
/// locator.get<NavigationService>().navigateTo("");

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (buildContext, model, child) {
        return ScreenTypeLayout(
          mobile: OrientationLayout(
            portrait: HomeMobileScreenWidget(),
            landscape: HomeMobileScreenWidget(),
          ),
          tablet: OrientationLayout(
            portrait: HomeMobileScreenWidget(),
            landscape: HomeLargeScreenWidget(),
          ),
          desktop: OrientationLayout(
            landscape: HomeLargeScreenWidget(),
            portrait: HomeLargeScreenWidget(),
          ),
        );
      },
    );
  }
}

class HomeMobileScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        actions: [buildTextWidget("Hello, Yana")],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildMusicBoard(),
              BuildBottomPlayer(listOfSampleSongs[0])
            ],
          ),
        ),
      ),
    );
  }
}

class BuildMusicBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Container(
                child: buildTextWidget("most\npopular",
                    fontSize: 40,
                    color: kWhiteColor.withOpacity(0.6),
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Container(
                  child: buildTextWidget("960 playlists",
                      fontSize: 16,
                      color: kWhiteColor.withOpacity(0.3),
                      fontWeight: FontWeight.w500),
                )),
            BuildRowOfPlaylist(),
            BuildRowOfNewReleases(),
            buildVerticalSpace(16)
          ],
        ),
      ),
    );
  }
}

class BuildRowOfPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: listOfSampleSongs.length,
          itemBuilder: (BuildContext context, int index) {
            return buildSongLargeWidget(listOfSampleSongs[index]);
          }),
    );
  }

  Widget buildSongLargeWidget(Song listOfSampleSong) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 8, 16, 8),
      child: Container(
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(listOfSampleSong.artistThumbImage),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(16),
          color: kWhiteColor.withOpacity(0.01),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextWidget(listOfSampleSong.songTitle,
                  color: kWhiteColor, fontWeight: FontWeight.bold),
              buildTextWidget(
                listOfSampleSong.artistName,
                color: kWhiteColor.withOpacity(0.75),
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BuildRowOfNewReleases extends StatefulWidget {
  @override
  _BuildRowOfNewReleasesState createState() => _BuildRowOfNewReleasesState();
}

class _BuildRowOfNewReleasesState extends State<BuildRowOfNewReleases> {
  Song selectedSong = listOfSampleSongs[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildVerticalSpace(16),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Container(
              child: buildTextWidget("new releases",
                  color: kWhiteColor.withOpacity(0.6),
                  fontSize: 24,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Container(
              child: buildTextWidget(
                "3454 songs",
                color: kWhiteColor.withOpacity(0.3),
                fontSize: 16,
              ),
            ),
          ),
          Container(
            height: 96,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listOfSampleSongs.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return buildArtistPreview(listOfSampleSongs[index]);
                }),
          ),
          Center(
            child: Container(
              width: 56,
              child: Divider(
                thickness: 2,
                color: kAccentColor,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildVerticalSpace(8),
                buildTextWidget(selectedSong.songTitle,
                    color: kWhiteColor.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                buildTextWidget(selectedSong.songTitle,
                    color: kWhiteColor.withOpacity(0.4), fontSize: 14),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildArtistPreview(Song song) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSong = song;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 64,
              width: 64,
              color: Colors.red,
              child: Image.network(
                song.artistThumbImage,
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}

class BuildBottomPlayer extends StatefulWidget {
  final Song song;
  BuildBottomPlayer(this.song);

  @override
  _BuildBottomPlayerState createState() => _BuildBottomPlayerState();
}

class _BuildBottomPlayerState extends State<BuildBottomPlayer> {
  Duration _duration = new Duration(seconds: 300);
  Duration _position = new Duration(seconds: 100);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Color(0xFF10121C),
      child: Column(
        children: [
          buildVerticalSpace(8),
          Row(
            children: [
              buildArtistImage(),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildVerticalSpace(8),
                        buildTextWidget(widget.song.songTitle,
                            color: kWhiteColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        buildTextWidget(widget.song.songTitle,
                            color: kWhiteColor.withOpacity(0.4), fontSize: 14),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.pause,
                  color: kWhiteColor,
                  size: 32,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.fast_forward,
                  color: kWhiteColor,
                  size: 32,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: buildTextWidget("0:23",
                      color: kWhiteColor.withOpacity(0.2), fontSize: 14),
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      thumbColor: Colors.transparent,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 0.0)),
                  child: Slider(
                      activeColor: Colors.white.withOpacity(0.8),
                      inactiveColor: Colors.white.withOpacity(0.1),
                      value: _position.inSeconds.toDouble(),
                      min: 0.0,
                      max: _duration.inSeconds.toDouble(),
                      onChanged: (double value) {
                        setState(() {
                          seekToSecond(value.toInt());
                          value = value;
                        });
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: buildTextWidget("3:56",
                      color: kWhiteColor.withOpacity(0.8), fontSize: 14),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    //advancedPlayer.seek(newDuration);
  }

  Padding buildArtistImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: Image.network(
          widget.song.artistThumbImage,
          height: 48,
          width: 48,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class HomeLargeScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
