import 'dart:math';

class DewPoint {
  /// Calculate dew point in °C for a given
  /// temperature [t] in °C and rel humidity [h] in %
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
  static double calcDewPoint(double t, double h) {
    const b = 17.269;
    const c = 237.3;

    final x = log(h / 100.0) + (b * t) / (c + t);
    return (c * x) / (b - x);
  }

  /// Calculate absolute water in air in g/m³ for a given
  /// temperature [t] in °C and rel humidity [h] in %
  ///
  /// valid in temperature rage -40 ... 50°C
  ///
  /// Luftfeuchte
  /// https://www.wetterochs.de/wetter/feuchte.html
  static double calcAbsoluteHumidity(double t, double h) {
    final a = t > 0 ? 7.5 : 7.6;
    final b = t > 0 ? 237.3 : 240.7;

    // absolute temperature in K
    final T = t + 273.25;

    // dew point
    final td = calcDewPoint(t, h);

    // saturated water vapor pressure in hPa
    final ps = 6.1078 * pow(10.0, (a * td) / (b + td));

    // absolute water content in g/m³
    return 218.42 * ps / T;
  }

  /// Calculate relative humidity in % for a given
  /// temperature [t] in °C and dew point [dp] in °C
  ///
  /// valid in temperature rage -40 ... 50°C
  ///
  static double calcRelativeHumidity(double t, double dp) {
    const b = 17.269;
    const c = 237.3;

    final x = dp * b / (dp + c);
    final y = x - b * t / (c + t);

    return 100.0 * exp(y);
  }

  /// Calculate temperature in °C  for a given
  /// relative humidity [h] in % and dew point [dp] in °C
  ///
  /// valid in temperature rage -40 ... 50°C
  ///
  static double calcTemperature(double h, double dp) {
    const b = 17.269;
    const c = 237.3;

    final x = dp * b / (dp + c);
    final y = x - log(h / 100.0);

    return y * c / (b - y);
  }
}
