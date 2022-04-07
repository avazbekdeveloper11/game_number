import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameInitial());
  int i = 0;
  int count = 0;
  List<int> nums = [];
  List<int> numsSort = [];
  List<Color> colors = [];
  Color textColor = Colors.black;
  bool isTab = true;
  bool isTap = false;

  generateRandom() {
    bool generate = true;
    i = 0;
    Set<int> numbers = {};
    nums.clear();
    numbers.clear();
    numsSort.clear();
    textColor = Colors.black;
    while (generate) {
      if (numbers.length == 5) {
        generate = false;
        nums.addAll(numbers);
        numsSort.addAll(numbers);
        numsSort.sort();
        emit(NumGenerateFinish());
      } else {
        int rand = Random().nextInt(10);
        numbers.add(rand);
      }
    }
    colors.clear();
    colors = List.generate(nums.length, (index) => Colors.red);
    changeTextColor();
  }

  changeColor(int index) {
    print("object");
    print(nums);
    print(numsSort);
    if (numsSort[0] == nums[index]) {
      colors[index] = Colors.transparent;
      numsSort.removeAt(0);
    } else if (numsSort.isEmpty) {
      isTab = true;
      isTap = false;
      generateRandom();
    }
    emit(ChangeColorState());
  }

  changeTextColor() async {
    isTab = false;
    await Future.delayed(
        const Duration(seconds: 5), () => textColor = Colors.transparent);
    isTap = true;
    emit(ChangeTextColorState());
  }
}
