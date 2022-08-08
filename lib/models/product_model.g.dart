// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsAdapter extends TypeAdapter<Products> {
  @override
  final int typeId = 1;

  @override
  Products read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Products(
      id: fields[0] as int?,
      nameAr: fields[1] as String?,
      nameEn: fields[2] as String?,
      descriptionAr: fields[3] as String?,
      descriptionEn: fields[4] as String?,
      price: fields[5] as String?,
      stock: fields[6] as int?,
      offer: fields[7] as double?,
      count: fields[8] as int?,
      categoryId: fields[9] as int?,
      images: (fields[10] as List?)?.cast<Images>(),
    );
  }

  @override
  void write(BinaryWriter writer, Products obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameAr)
      ..writeByte(2)
      ..write(obj.nameEn)
      ..writeByte(3)
      ..write(obj.descriptionAr)
      ..writeByte(4)
      ..write(obj.descriptionEn)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.stock)
      ..writeByte(7)
      ..write(obj.offer)
      ..writeByte(8)
      ..write(obj.count)
      ..writeByte(9)
      ..write(obj.categoryId)
      ..writeByte(10)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImagesAdapter extends TypeAdapter<Images> {
  @override
  final int typeId = 2;

  @override
  Images read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Images(
      id: fields[0] as int?,
      name: fields[1] as String?,
      productId: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Images obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.productId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
