// 25/05/12 = Mon

/**
 * @file today.cpp
 *
 * @brief Prints the current date in the `YY/MM/DD = Www` format.
 */

#include <chrono>
#include <format>
#include <iostream>
#include <string>

#ifndef VERSION
#define VERSION "develop"
#endif

static constexpr const char *WEEK_NAMES[] = {"Sun", "Mon", "Tue", "Wed",
                                             "Thu", "Fri", "Sat"};
static constexpr const char *HELP =
    "Prints the current date in the \"YY/MM/DD = Www\" format.\n\n"
    "Usage: today [-h, --help] [-v, --version]\n\n"
    "Options:\n"
    "  -h, --help     show this help and exit\n"
    "  -v, --version  show version number and exit\n\n"
    "Examples:\n"
    "  today          print \"25/05/16 = Fri\", assuming\n"
    "                 it's Friday 16 May, 2025 today\n\n"
    "Report bugs to <aaron.fu@alumni.ust.hk>.";
static constexpr const char *AUTHOR = "Written by Aaron Fu Lei.";

static constexpr const char *COPYRIGHT =
    "Copyright (c) 2025 Aaron Fu Lei. All rights reserved.";

/**
 * @brief Retrieves today's date and formats it as a string.
 *
 * Returns a string in the `YY/MM/DD = Www` format, e.g.
 *
 * ```
 * 25/05/14 = Wed
 * ```
 *
 * @return std::string Formatted date string representing today's date.
 */
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
                     WEEK_NAMES[weekday.c_encoding()]);
}

void show_help() { std::cout << HELP << std::endl; }

void show_version()
{
  std::cout << "today " << VERSION << "\n\n"
            << COPYRIGHT << "\n\n"
            << AUTHOR << std::endl;
}

/**
 * @brief Main entry point of the program.
 *
 * Prints the formatted current date string to standard output.
 *
 * @return int Exit code (0 for success).
 */
int main(int argc, char *argv[])
{
  if (argc > 1) {
    std::string arg = argv[1];
    if (arg == "-h" || arg == "--help") {
      show_help();
      return 0;
    } else if (arg == "-v" || arg == "--version") {
      show_version();
      return 0;
    } else {
      std::cerr << "Unrecognized argument: " << arg << std::endl;
      return 1;
    }
  }
  std::cout << get_today_formatted();
  return 0;
}
