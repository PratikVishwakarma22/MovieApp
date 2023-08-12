function favourite_movies() {
  const response = fetch(`https://localhost:3000/favourites`);
  const data = response.json();
  console.log(data)
  return data; // Return the parsed JSON data
}

