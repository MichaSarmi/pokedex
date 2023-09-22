import 'dart:convert';

class PokemonListModel {
    List<Content> content;
    Pageable pageable;

    PokemonListModel({
        required this.content,
        required this.pageable,
    });

    factory PokemonListModel.fromJson(String str) => PokemonListModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PokemonListModel.fromMap(Map<String, dynamic> json) => PokemonListModel(
        content: List<Content>.from(json["content"].map((x) => Content.fromMap(x))),
        pageable: Pageable.fromMap(json["pageable"]),
    );

    Map<String, dynamic> toMap() => {
        "content": List<dynamic>.from(content.map((x) => x.toMap())),
        "pageable": pageable.toMap(),
    };
}

class Content {
    int id;
    String name;
    String href;
    String image;

    Content({
        required this.id,
        required this.name,
        required this.href,
        required this.image,
    });

    factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Content.fromMap(Map<String, dynamic> json) => Content(
        id: json["id"],
        name: json["name"],
        href: json["href"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "href": href,
        "image": image,
    };
}

class Pageable {
    int currentPage;
    int elementsOnPage;
    int totalElements;
    int totalPages;
    String previousPage;
    String nextPage;

    Pageable({
        required this.currentPage,
        required this.elementsOnPage,
        required this.totalElements,
        required this.totalPages,
        required this.previousPage,
        required this.nextPage,
    });

    factory Pageable.fromJson(String str) => Pageable.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pageable.fromMap(Map<String, dynamic> json) => Pageable(
        currentPage: json["currentPage"],
        elementsOnPage: json["elementsOnPage"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        previousPage: json["previousPage"],
        nextPage: json["nextPage"],
    );

    Map<String, dynamic> toMap() => {
        "currentPage": currentPage,
        "elementsOnPage": elementsOnPage,
        "totalElements": totalElements,
        "totalPages": totalPages,
        "previousPage": previousPage,
        "nextPage": nextPage,
    };
}