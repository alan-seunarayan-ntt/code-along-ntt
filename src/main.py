"""
Sample Python application
Demonstrates UK English locale formatting and date handling
"""

import locale
from datetime import datetime
from typing import Optional


class UKGreeting:
    """A class that provides UK-style greetings and formatting."""

    def __init__(self) -> None:
        self.default_locale = "en_GB.UTF-8"

    def greet(self, name: str, custom_locale: Optional[str] = None) -> str:
        """
        Generate a greeting with UK-formatted date and time.

        Args:
            name: The name to greet
            custom_locale: Optional custom locale (defaults to UK English)

        Returns:
            A formatted greeting string
        """
        target_locale = custom_locale or self.default_locale

        try:
            # Try to set the locale (may not work in all environments)
            locale.setlocale(locale.LC_TIME, target_locale)
        except locale.Error:
            print(f"Warning: Could not set locale to {target_locale}")

        now = datetime.now()

        # UK date format: DD/MM/YYYY
        uk_date = now.strftime("%d/%m/%Y")

        # 24-hour time format (common in UK)
        uk_time = now.strftime("%H:%M")

        return f"Good day, {name}! Today is {uk_date} at {uk_time}."


def main() -> None:
    """Main function demonstrating the UK greeting functionality."""
    greeting = UKGreeting()

    print(greeting.greet("Developer"))
    print("Environment setup complete for Ubuntu with UK English locale.")
    print("Supported technologies: Node.js, TypeScript, Python, .NET 9")

    # Display current locale information
    try:
        current_locale = locale.getlocale()
        print(f"Current Python locale: {current_locale}")
    except Exception as e:
        print(f"Could not retrieve locale information: {e}")


if __name__ == "__main__":
    main()
