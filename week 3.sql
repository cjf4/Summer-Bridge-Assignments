DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS reviews;

CREATE TABLE videos (
    VideoID int PRIMARY KEY,
    title text NOT NULL,
    length numeric,
    url text NOT NULL
);

INSERT INTO videos ( VideoID, title, length, url) VALUES (1, 'Norm MacDonald on the Dennis Miller Show', 98, 'https://www.youtube.com/watch?v=ZpOol74qhqQ');
INSERT INTO videos ( VideoID, title, length, url) VALUES (2, 'Waiting For Guffman - My Dinner with Andre action figures', 1, 'https://www.youtube.com/watch?v=5WwZkbAvBtk');
INSERT INTO videos ( VideoID, title, length, url) VALUES (3, 'Greatest Ric Flair Promo', 7, 'https://www.youtube.com/watch?v=b_3jW_0jnzc');

CREATE TABLE reviews (
    username varchar NOT NULL,
    rating int,
    VideoID int NOT NULL
    CONSTRAINT chk_rating CHECK (rating IN ( NULL, 0, 1, 2, 3, 4, 5))

);

INSERT INTO reviews ( username, rating, VideoID) VALUES ( 'blenhorse', 4, 1);
INSERT INTO reviews ( username, rating, VideoID) VALUES ( 'mrfurley', 5, 1);
INSERT INTO reviews ( username, rating, VideoID) VALUES ( 'mrfurley', 2, 3);
INSERT INTO reviews ( username, rating, VideoID) VALUES ( 'tbone', 5, 3);

SELECT
    rating,
    title
FROM reviews
INNER JOIN videos
ON videos.VideoID = reviews.VideoID
WHERE title = 'Norm MacDonald on the Dennis Miller Show';
