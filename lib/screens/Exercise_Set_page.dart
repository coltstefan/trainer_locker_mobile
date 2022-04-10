import 'package:flutter/cupertino.dart';
import 'package:mobile_final/models/ExerciseSet.dart';

import 'animated_exercise_set.dart';

class ExerciseSetPage extends StatefulWidget {
  const ExerciseSetPage({ Key key , this.index, this.exerciseSets}) : super(key: key);

  final int index;
  final List<ExerciseSet> exerciseSets;

  @override
  State<ExerciseSetPage> createState() => _ExerciseSetPageState();
}

class _ExerciseSetPageState extends State<ExerciseSetPage>
    with SingleTickerProviderStateMixin {
   AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this
      );
      _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedExerciseSet(
      controller: _controller,
      index: widget.index,
      exerciseSetList: widget.exerciseSets,
    );
  }
}