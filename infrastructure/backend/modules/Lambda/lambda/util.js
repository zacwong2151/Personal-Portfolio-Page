/**
 * Converts a timestamp (number of milliseconds since epoch) to a human-readable
 * date and time string.
 *
 * @param {number} timestampMs The timestamp in milliseconds since the Unix epoch.
 * @param {string} [locale='en-US'] The locale to use for formatting (e.g., 'en-US', 'en-GB', 'fr-FR').
 * Defaults to 'en-US'.
 * @param {object} [options] Optional formatting options for Date.prototype.toLocaleString.
 * Defaults to displaying full date and time.
 * @returns {string} The formatted date and time string.
 */
export function convertTimestampToReadableDateTime(
  timestampMs,
  locale = 'en-GB',
  options = {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    hour12: true, // Use 12-hour clock with AM/PM
    timeZoneName: 'shortOffset',
    timeZone: 'Asia/Singapore', // Explicitly set the time zone to GMT+8
  }
) {
  if (typeof timestampMs !== 'number' || isNaN(timestampMs)) {
    console.error("Invalid timestamp provided. Please provide a number in milliseconds.");
    return "Invalid Date";
  }

  const date = new Date(timestampMs);

  // Check if the date is valid after conversion
  if (isNaN(date.getTime())) {
    console.error("Timestamp resulted in an invalid Date object.");
    return "Invalid Date";
  }

  // Use toLocaleString for flexible and locale-aware formatting
  return date.toLocaleString(locale, options);
}
