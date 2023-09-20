class SubmitRouteHelpers{

  static String convertToString(List<String> list) {
    final string = list.toString();
    final removedBrackets = string.substring(1, string.length - 1);
    final parts = removedBrackets.split(',');
    var joined = parts.map((part) => "$part").join('');
    return joined;
  }
  List<String> getTags(tags) {
    List<String> splitTags = tags.split(' ');
    List<String> tempList = [];
    for (int i = 0; i < splitTags.length; i++) {
      if (splitTags[i].trim().isNotEmpty) {
        tempList.add(splitTags[i]);
      }
    }
    return tempList;
  }

}