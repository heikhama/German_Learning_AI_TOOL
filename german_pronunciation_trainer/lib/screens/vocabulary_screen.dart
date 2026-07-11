import 'package:flutter/material.dart';

import '../models/vocabulary.dart';
import '../services/vocabulary_service.dart';

class VocabularyScreen extends StatefulWidget {

  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() =>
      _VocabularyScreenState();

}

class _VocabularyScreenState
    extends State<VocabularyScreen> {

  List<Vocabulary> vocabulary = [];

  List<Vocabulary> filteredVocabulary = [];

  bool loading = true;

  final TextEditingController searchController =
      TextEditingController();

  //---------------------------------------------------------
  @override
  void initState() {

    super.initState();

    loadVocabulary();

  }

  //---------------------------------------------------------
  Future<void> loadVocabulary() async {

    try {

      final list =
          await VocabularyService.getVocabulary();

      if (!mounted) return;

      setState(() {

        vocabulary = list;

        filteredVocabulary = list;

        loading = false;

      });

    } catch (e) {

      debugPrint(e.toString());

      if (!mounted) return;

      setState(() {

        loading = false;

      });

    }

  }

  //---------------------------------------------------------
  void searchWord(String keyword) {

    setState(() {

      filteredVocabulary = vocabulary.where((item) {

        return item.word
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||

            item.meaning
                .toLowerCase()
                .contains(keyword.toLowerCase());

      }).toList();

    });

  }

  //---------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    if (loading) {

      return const Center(

        child: CircularProgressIndicator(),

      );

    }

    return Column(

      children: [

        //--------------------------------------------------
        // Search Box
        //--------------------------------------------------

        Padding(

          padding: const EdgeInsets.all(15),

          child: TextField(

            controller: searchController,

            decoration: InputDecoration(

              hintText: "Search vocabulary",

              prefixIcon: const Icon(Icons.search),

              border: OutlineInputBorder(

                borderRadius:
                    BorderRadius.circular(12),

              ),

            ),

            onChanged: searchWord,

          ),

        ),

        //--------------------------------------------------
        // List
        //--------------------------------------------------

        Expanded(

          child: ListView.builder(

            itemCount: filteredVocabulary.length,

            itemBuilder: (context, index) {

              final word =
                  filteredVocabulary[index];

              return Card(

                margin: const EdgeInsets.symmetric(

                  horizontal: 15,

                  vertical: 6,

                ),

                child: ListTile(

                  leading: CircleAvatar(

                    child: Text(

                      word.cefrLevel,

                    ),

                  ),

                  title: Text(

                    word.word,

                    style: const TextStyle(

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  subtitle: Text(

                    word.meaning,

                  ),

                  trailing: const Icon(

                    Icons.arrow_forward_ios,

                    size: 18,

                  ),

                  onTap: () {

                    // Phase 3

                  },

                ),

              );

            },

          ),

        ),

      ],

    );

  }

}