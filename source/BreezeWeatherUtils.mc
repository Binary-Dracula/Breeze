using Toybox.Weather;
using Toybox.Lang;

class BreezeWeatherUtils {

    // 小时天气预报
    function getHourlyWeather() as Lang.Array<Weather.HourlyForecast> or Null{
        var hourlyForecast = Weather.getHourlyForecast() as Lang.Array<Weather.HourlyForecast>;
        if (hourlyForecast != null) {
            return hourlyForecast;
        }
        return null;
    }

    // 当前小时天气预报
    function getCurrentHourlyWeather() as Weather.HourlyForecast or Null {
        var hourlyWeather = getHourlyWeather() as Lang.Array<Weather.HourlyForecast>;
        if (hourlyWeather != null) {
            return hourlyWeather[0];
        }
        return null;
    }

    // 当前温度
    function getCurrentTemperature() as Lang.Number {
        var currentHourlyWeather = getCurrentHourlyWeather();
        if (currentHourlyWeather != null) {
            return currentHourlyWeather.temperature;
        }
        return 0;
    }

}