import 'dart:math';

/// Calculate dew point for a given temperature [t] and
/// humidity [h]
///
/// valid in temperature rage -40 ... 50°C
///
/// Source:
/// Lawrence, M. (2005): The Relationship between Relative Humidity and the Dewpoint Temperature in Moist Air:
/// A Simple Conversion and Applications. Bulletin of the American Meteorological Society,
/// Vol. 86: Issue 2, p. 225
///
/// DOI:10.1175/BAMS-86-2-225
/// https://journals.ametsoc.org/view/journals/bams/86/2/bams-86-2-225.xml
///
double calcDewPoint(double t, double h) {
  const b = 17.269;
  const c = 237.3;

  final x = log(h / 100.0) + (b * t) / (c + t);
  return (c * x) / (b - x);
}
