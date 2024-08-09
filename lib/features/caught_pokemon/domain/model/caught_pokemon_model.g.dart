// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caught_pokemon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaughtPokemonModelAdapter extends TypeAdapter<CaughtPokemonModel> {
  @override
  final int typeId = 0;

  @override
  CaughtPokemonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaughtPokemonModel(
      name: fields[0] as String,
      pokedexNum: fields[1] as int?,
      types: (fields[2] as List).cast<PokemonType>(),
      isShiny: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CaughtPokemonModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.pokedexNum)
      ..writeByte(2)
      ..write(obj.types)
      ..writeByte(3)
      ..write(obj.isShiny);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaughtPokemonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
