"""
Test module for main.py
Tests UK greeting functionality
"""

from src.main import UKGreeting


class TestUKGreeting:
    """Test cases for the UKGreeting class."""

    def setup_method(self):
        """Set up test fixtures."""
        self.greeting = UKGreeting()

    def test_greet_contains_expected_elements(self):
        """Test that greeting contains expected text elements."""
        result = self.greeting.greet("Test User")

        assert "Good day, Test User!" in result
        assert "Today is" in result

        # Check for UK date format pattern (DD/MM/YYYY)
        import re

        date_pattern = r"\d{2}/\d{2}/\d{4}"
        assert re.search(date_pattern, result) is not None

        # Check for 24-hour time format pattern (HH:MM)
        time_pattern = r"\d{2}:\d{2}"
        assert re.search(time_pattern, result) is not None

    def test_greet_returns_string(self):
        """Test that greet method returns a string."""
        result = self.greeting.greet("Another User")
        assert isinstance(result, str)
        assert len(result) > 0

    def test_greet_with_custom_locale(self):
        """Test greeting with custom locale parameter."""
        result = self.greeting.greet("Custom User", "en_US.UTF-8")
        assert "Good day, Custom User!" in result

    def test_default_locale_property(self):
        """Test that default locale is set correctly."""
        assert self.greeting.default_locale == "en_GB.UTF-8"
