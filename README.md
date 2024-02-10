# Greeklish

Converts greeklish i.e 'ti kanete' to greek 'τι κάνετε' and applies appropriate spell-checking.
Experimented with the Levenshtein algorithm.


### **High level Algorithm explanation**

`> Convert greeklish to greek`

`>> Build a BK-tree out of the greek dictionary`

On the first run, it builds a BK-tree out of a 500,000-word Greek dictionary `greek.dic` and stores it in memory. It will also create a local "bk_tree.yml" file, so on subsequent runs, it can be used directly, resulting in faster loading.

[What is a bk-tree](https://www.youtube.com/watch?v=oIsPB2pqq_8)

`>> One to one mapping latin to greek conversion`

This is nothing but a one to one mapping of each latin letter into its greek equivalent, specified by the en.yml file, with only few special cases of diphthongs.

`>> Greek approximate spell checking / fuzzy search`

For each mapped word to its greek equivalent, it parses the bk-tree and transforms it to the closest word it finds, specified by the `DIST_THRESHOLD` constant with a default value of 1. Meaning, it will either return exact matches of 0 distance or the first 3 matches with distance 1. example: αυπο -> "αυτό/αυγό". The larger the `DIST_THRESHOLD` the slower the performance.

[Understanding Levenshtein edit distance (article)](https://medium.com/@ethannam/understanding-the-levenshtein-distance-equation-for-beginners-c4285a5604f0)

[Understanding Levenshtein edit distance (video)](https://www.youtube.com/watch?v=b6AGUjqIPsA)


### How to run

```ruby

irb

require './lib/greeklish'

Greeklish.convert('ti kanete')

```
