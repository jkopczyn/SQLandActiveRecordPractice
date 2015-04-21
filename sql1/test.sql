SELECT
  styles.style, AVG(price_per_track)
FROM
  styles
JOIN
  (
  SELECT
    album, price / COUNT(tracks.song) AS price_per_track
  FROM
    albums
  JOIN
    tracks ON albums.asin = tracks.album
  GROUP BY
    asin
  )
  ON styles.album = albums.asin
GROUP BY
  styles.style
ORDER BY
  AVG(price_per_track) DESC
LIMIT
  1;
