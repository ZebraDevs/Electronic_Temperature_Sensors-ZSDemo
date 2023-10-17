double closest(double num, List<double> arr) {
  var curr = arr[0];
  var diff = (num - curr).abs();
  for (var val = 0; val < arr.length; val++) {
    var newdiff = (num - arr[val]).abs();
    if (newdiff < diff) {
      diff = newdiff;
      curr = arr[val];
    }
  }
  return curr;
}
