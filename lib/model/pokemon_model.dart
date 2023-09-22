import 'dart:convert';

class PokemonModel {
    int? id;
    String? name;
    bool? xAntibody;
    List<Image>? images;
    List<Level>? levels;
    List<Type>? types;
    List<Attribute>? attributes;
    List<Field>? fields;
    String? releaseDate;
    List<Description> ?descriptions;
    List<Skill>? skills;
    List<Evolution>? priorEvolutions;
    List<Evolution>? nextEvolutions;

    PokemonModel({
         this.id,
         this.name,
         this.xAntibody,
         this.images,
         this.levels,
         this.types,
         this.attributes,
         this.fields,
         this.releaseDate,
         this.descriptions,
         this.skills,
         this.priorEvolutions,
         this.nextEvolutions,
    });

    factory PokemonModel.fromJson(String str) => PokemonModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PokemonModel.fromMap(Map<String, dynamic> json) => PokemonModel(
        id: json["id"],
        name: json["name"],
        xAntibody: json["xAntibody"],
        images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
        levels: List<Level>.from(json["levels"].map((x) => Level.fromMap(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
        attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromMap(x))),
        fields: List<Field>.from(json["fields"].map((x) => Field.fromMap(x))),
        releaseDate: json["releaseDate"],
        descriptions: List<Description>.from(json["descriptions"].map((x) => Description.fromMap(x))),
        skills: List<Skill>.from(json["skills"].map((x) => Skill.fromMap(x))),
        priorEvolutions: List<Evolution>.from(json["priorEvolutions"].map((x) => Evolution.fromMap(x))),
        nextEvolutions: List<Evolution>.from(json["nextEvolutions"].map((x) => Evolution.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "xAntibody": xAntibody,
        "images": List<dynamic>.from(images!.map((x) => x.toMap())),
        "levels": List<dynamic>.from(levels!.map((x) => x.toMap())),
        "types": List<dynamic>.from(types!.map((x) => x.toMap())),
        "attributes": List<dynamic>.from(attributes!.map((x) => x.toMap())),
        "fields": List<dynamic>.from(fields!.map((x) => x.toMap())),
        "releaseDate": releaseDate,
        "descriptions": List<dynamic>.from(descriptions!.map((x) => x.toMap())),
        "skills": List<dynamic>.from(skills!.map((x) => x.toMap())),
        "priorEvolutions": List<dynamic>.from(priorEvolutions!.map((x) => x.toMap())),
        "nextEvolutions": List<dynamic>.from(nextEvolutions!.map((x) => x.toMap())),
    };
}

class Attribute {
    int id;
    String attribute;

    Attribute({
        required this.id,
        required this.attribute,
    });

    factory Attribute.fromJson(String str) => Attribute.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Attribute.fromMap(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        attribute: json["attribute"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "attribute": attribute,
    };
}

class Description {
    String origin;
    String language;
    String description;

    Description({
        required this.origin,
        required this.language,
        required this.description,
    });

    factory Description.fromJson(String str) => Description.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Description.fromMap(Map<String, dynamic> json) => Description(
        origin: json["origin"],
        language: json["language"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "origin": origin,
        "language": language,
        "description": description,
    };
}

class Field {
    int id;
    String field;
    String image;

    Field({
        required this.id,
        required this.field,
        required this.image,
    });

    factory Field.fromJson(String str) => Field.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Field.fromMap(Map<String, dynamic> json) => Field(
        id: json["id"],
        field: json["field"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "field": field,
        "image": image,
    };
}

class Image {
    String href;
    bool transparent;

    Image({
        required this.href,
        required this.transparent,
    });

    factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Image.fromMap(Map<String, dynamic> json) => Image(
        href: json["href"],
        transparent: json["transparent"],
    );

    Map<String, dynamic> toMap() => {
        "href": href,
        "transparent": transparent,
    };
}

class Level {
    int id;
    String level;

    Level({
        required this.id,
        required this.level,
    });

    factory Level.fromJson(String str) => Level.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Level.fromMap(Map<String, dynamic> json) => Level(
        id: json["id"],
        level: json["level"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "level": level,
    };
}

class Evolution {
    int? id;
    String digimon;
    String condition;
    String image;
    String url;

    Evolution({
        required this.id,
        required this.digimon,
        required this.condition,
        required this.image,
        required this.url,
    });

    factory Evolution.fromJson(String str) => Evolution.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Evolution.fromMap(Map<String, dynamic> json) => Evolution(
        id: json["id"],
        digimon: json["digimon"],
        condition: json["condition"],
        image: json["image"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "digimon": digimon,
        "condition": condition,
        "image": image,
        "url": url,
    };
}

class Skill {
    int id;
    String skill;
    String translation;
    String description;

    Skill({
        required this.id,
        required this.skill,
        required this.translation,
        required this.description,
    });

    factory Skill.fromJson(String str) => Skill.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Skill.fromMap(Map<String, dynamic> json) => Skill(
        id: json["id"],
        skill: json["skill"],
        translation: json["translation"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "skill": skill,
        "translation": translation,
        "description": description,
    };
}

class Type {
    int id;
    String type;

    Type({
        required this.id,
        required this.type,
    });

    factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Type.fromMap(Map<String, dynamic> json) => Type(
        id: json["id"],
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
    };
}
