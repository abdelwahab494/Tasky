enum EncourageEnum {
  isDone(firstSentence: "Awesome! Your work", secSentence: "is all done.  "),
  isGoing(firstSentence: "Yuhuu! Your work Is", secSentence: "almost done !  "),
  started(
    firstSentence: "Let's go! Your work is",
    secSentence: "ready to begin.  ",
  ),
  begin(firstSentence: "No tasks yet.", secSentence: "add your first one !  ");

  final String firstSentence;
  final String secSentence;

  const EncourageEnum({required this.firstSentence, required this.secSentence});
}
