import 'package:flutter/material.dart';

// ... Other imports ...

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum MovieCategory {
  Latest,
  NowPlaying,
  Popular,
  TopRated,
  Upcoming,
}

class _HomeScreenState extends State<HomeScreen> {
  // ... Other properties and methods ...

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies App'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) {
              setState(() {
                searchKeyword = value;
              });
              initialize(selectedCategory);
            },
            decoration: InputDecoration(
              hintText: 'Cari film...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Column(
            children: MovieCategory.values.map((category) {
              return RadioListTile<MovieCategory>(
                title: Text(category.toString().split('.').last),
                value: category,
                groupValue: selectedCategory,
                onChanged: (MovieCategory? value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                  initialize(value);
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text('Kata Kunci:'),
          Wrap(
            children: <Widget>[
              KeywordChip(
                'Horor',
                onDelete: () {
                  // Tambahkan logika di sini untuk menghapus kata kunci "Horor"
                },
              ),
              KeywordChip(
                'Comedy',
                onDelete: () {
                  // Tambahkan logika di sini untuk menghapus kata kunci "Comedy"
                },
              ),
              // Tambahkan kata kunci lain jika diperlukan
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: (movies?.length == null) ? 0 : movies!.length,
              itemBuilder: (BuildContext context, int position) {
                if (movies![position].posterPath != null) {
                  image = NetworkImage(iconBase + movies![position].posterPath);
                } else {
                  image = NetworkImage(defaultImage);
                }
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (_) => DetailScreen(movies![position]),
                      );
                      Navigator.push(context, route);
                    },
                    leading: CircleAvatar(
                      backgroundImage: image,
                    ),
                    title: Text(movies![position].title),
                    subtitle: Text('Released: ' +
                        movies![position].releaseDate +
                        ' - Vote: ' +
                        movies![position].voteAverage.toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
