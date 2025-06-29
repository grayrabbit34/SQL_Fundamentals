--film tablosunda film uzunluğu length sütununda gösterilmektedir. Uzunluğu ortalama film uzunluğundan fazla kaç tane film vardır?

SELECT COUNT(*) FROM film
WHERE length > (SELECT AVG (length) FROM film);


--film tablosunda en yüksek rental_rate değerine sahip kaç tane film vardır?
SELECT COUNT(*) 
FROM film 
WHERE rental_rate = (SELECT MAX(rental_rate) FROM film);

--film tablosunda en düşük rental_rate ve en düşün replacement_cost değerlerine sahip filmleri sıralayınız.

SELECT * FROM film 
WHERE rental_rate = (SELECT MIN(rental_rate) FROM film) AND 
replacement_cost = (SELECT MIN(replacement_cost) FROM film ) ;

--diğer yöntem

SELECT * FROM film
WHERE (rental_rate, replacement_cost) = ALL 
(
  SELECT MIN(rental_rate), MIN(replacement_cost) FROM film
);


--payment tablosunda en fazla sayıda alışveriş yapan müşterileri(customer) sıralayınız.
SELECT customer.* FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id 
GROUP BY customer.customer_id
HAVING COUNT(*) = 
(
	SELECT MAX(payment_count)
	FROM
	(
		SELECT customer_id,COUNT(*) AS payment_count
		FROM payment
		GROUP BY customer_id
	)
);



