// 25/05/12 = Mon

#include <chrono>
#include <format>
#include <iostream>
#include <string>

static constexpr const char *week_names[] = {"Sun", "Mon", "Tue", "Wed",
                                             "Thu", "Fri", "Sat"};

std::string get_today_formatted()
{
  auto today =
      std::chrono::floor<std::chrono::days>(std::chrono::system_clock::now());
  auto ymd = std::chrono::year_month_day{today};
  auto weekday = std::chrono::weekday{today};
  int yy = int(ymd.year()) % 100;
  int mm = unsigned(ymd.month());
  int dd = unsigned(ymd.day());
  return std::format("{:02}/{:02}/{:02} = {}", yy, mm, dd,
                     week_names[weekday.c_encoding()]);
}

int main()
{
  std::cout << get_today_formatted();
  return 0;
}
