import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/entities/movie_entity.dart';
import '../../../../model/enums/load_status.dart';
import '../../../widgets/loading_more_row_widget.dart';
import '../../movie_detail/movie_detail_view.dart';
import '../enums/home_section.dart';
import 'movies_section_logic.dart';
import 'movies_section_state.dart';
import 'widgets/loading_list_widget.dart';
import 'widgets/movie_widget.dart';

class MoviesSectionPage extends StatefulWidget {
  final HomeSection section;

  MoviesSectionPage(this.section);

  @override
  _MoviesSectionPageState createState() => _MoviesSectionPageState();
}

class _MoviesSectionPageState extends State<MoviesSectionPage> {
  final MoviesSectionLogic logic = Get.put(MoviesSectionLogic());
  final MoviesSectionState state = Get.find<MoviesSectionLogic>().state;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    logic.fetchInitialMovies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${widget.section.title}",
                  style: theme.textTheme.headline6,
                ),
                SizedBox(width: 10),
                Text(
                  "${widget.section.typeName}",
                  style: theme.textTheme.subtitle2,
                )
              ],
            ),
          ),
          Container(
            height: 160,
            width: double.infinity,
            child: buildContentWidget(),
          )
        ],
      ),
    );
  }

  Widget buildContentWidget() {
    return Obx(() {
      if (state.loadMovieStatus.value == LoadStatus.loading) {
        return _buildLoadingList();
      } else if (state.loadMovieStatus.value == LoadStatus.failure) {
        return Container();
      } else {
        return _buildSuccessList(
          state.movies,
          showLoadingMore: !state.hasReachedMax,
        );
      }
    });
  }

  Widget _buildLoadingList() {
    return LoadingListWidget();
  }

  Widget _buildSuccessList(List<MovieEntity> items, {bool showLoadingMore = false}) {
    return Container(
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return Container(
              height: 160,
              width: 82,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: MovieWidget(
                movie: item,
                onPressed: () {
                  Get.to(MovieDetailPage());
                },
              ),
            );
          } else {
            return LoadingMoreRowWidget();
          }
        },
        itemCount: showLoadingMore ? items.length + 1 : items.length,
        // controller: _scrollController,
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      logic.fetchNextMovies();
    }
  }
}
